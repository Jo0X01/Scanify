
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' show Placemark;
import 'package:latlong2/latlong.dart';

import '../exceptions/location_exceptions.dart';
import '../models/location_picker_result.dart';
import '../services/location_picker_service.dart';

/// Describes what the map / widget is currently doing.
enum LocationPickerStatus {
  /// Initial state — waiting for the first location load.
  loading,

  /// Location loaded and map is ready.
  ready,

  /// GPS / network error (could not get current location).
  locationError,

  /// Location service is disabled on the device.
  serviceDisabled,

  /// User denied location permission.
  permissionDenied,

  /// Map tiles failed to load (network issue).
  tileError,
}

/// Mediates between the UI and [LocationPickerService].
///
/// Owns all [ValueNotifier]s so widgets can rebuild only on the slice of state
/// they care about.  Business logic (geo calls, error mapping) lives in the
/// service; this class only decides *when* to call it and *how* to expose the
/// result.
class LocationPickerController {
  LocationPickerController({
    required LocationPickerResult? initialValue,
    required this.onSelectPosition,
    LocationPickerService? service,
  }) : _service = service ?? LocationPickerService(),
       _result = initialValue ?? LocationPickerResult(),
       mapController = MapController(),
       searchController = TextEditingController() {
    _locationNotifier = ValueNotifier(_result.location);
    _addressNotifier = ValueNotifier(_result.address);
    _statusNotifier = ValueNotifier(LocationPickerStatus.loading);
    _tileErrorNotifier = ValueNotifier(false);
  }

  // ---------------------------------------------------------------------------
  // Dependencies
  // ---------------------------------------------------------------------------

  final LocationPickerService _service;

  // ---------------------------------------------------------------------------
  // Flutter controllers (owned here, disposed here)
  // ---------------------------------------------------------------------------

  final MapController mapController;
  final TextEditingController searchController;

  // ---------------------------------------------------------------------------
  // State notifiers
  // ---------------------------------------------------------------------------

  late final ValueNotifier<LatLng?> _locationNotifier;
  late final ValueNotifier<String?> _addressNotifier;
  late final ValueNotifier<LocationPickerStatus> _statusNotifier;
  late final ValueNotifier<bool> _tileErrorNotifier;

  /// The current [LatLng] the marker is placed on (null = nothing picked yet).
  ValueNotifier<LatLng?> get locationNotifier => _locationNotifier;

  /// The reverse-geocoded address for the current location.
  ValueNotifier<String?> get addressNotifier => _addressNotifier;

  /// Overall widget status — drives loading spinners and error states.
  ValueNotifier<LocationPickerStatus> get statusNotifier => _statusNotifier;

  /// True when tile loading fails (e.g. no internet).
  ValueNotifier<bool> get tileErrorNotifier => _tileErrorNotifier;

  // ---------------------------------------------------------------------------
  // Internal mutable state
  // ---------------------------------------------------------------------------

  LocationPickerResult _result;

  /// Snapshot of the latest fully-resolved result.
  LocationPickerResult get result => _result;

  /// Callback fired every time the user picks or auto-loads a location.
  final void Function(LocationPickerResult)? onSelectPosition;

  // ---------------------------------------------------------------------------
  // Map lifecycle
  // ---------------------------------------------------------------------------

  void onMapReady() => _statusNotifier.value = LocationPickerStatus.ready;

  void onTileError() {
    _tileErrorNotifier.value = true;
  }

  // ---------------------------------------------------------------------------
  // Public actions
  // ---------------------------------------------------------------------------

  /// If the result is empty, auto-loads the device's current location.
  Future<void> loadCurrentLocationIfEmpty() async {
    if (!_result.isLocationEmpty) return;
    await _loadCurrentLocation();
  }

  /// Called when the user taps the map.
  Future<void> onMapTap(TapPosition tapPosition, LatLng tapped) async {
    await _resolveAndUpdate(tapped);
    onSelectPosition?.call(_result);
  }

  void zoomIn() {
    if (_result.isLocationEmpty) return;
    if ((mapController.camera.maxZoom ?? 4) <= mapController.camera.zoom + 3) {
      return;
    }
    mapController.move(_result.location!, mapController.camera.zoom + 3);
  }

  void zoomOut() {
    if (_result.isLocationEmpty) return;
    if ((mapController.camera.minZoom ?? 4) >= mapController.camera.zoom - 3) {
      return;
    }
    mapController.move(_result.location!, mapController.camera.zoom - 3);
  }

  /// Moves the map camera to the current result's location (if any).
  void goToCurrentLocation() {
    if (_result.isLocationEmpty) return;
    mapController.rotate(0);
    mapController.move(_result.location!, 16);
  }

  /// Fetches the device location, updates the result, then pans to it.
  Future<void> bringMeToCurrentLocation() async {
    await _loadCurrentLocation();
    goToCurrentLocation();
  }

  /// Geocodes the text in [searchController] and moves the map there.
  Future<void> searchAddress([String? query]) async {
    if(_locationNotifier.value == null) return;
    final q = query ?? searchController.text.trim();
    if (q.isEmpty) return;

    try {
      final latLng = await _service.getLocationFromAddress(q);
      await _resolveAndUpdate(latLng);
      goToCurrentLocation();
      onSelectPosition?.call(_result);
    } on GeocodingException {
      // Surface this to the UI via status if needed in the future.
    }
  }

  // ---------------------------------------------------------------------------
  // Disposal
  // ---------------------------------------------------------------------------

  void dispose() {
    _locationNotifier.dispose();
    _addressNotifier.dispose();
    _statusNotifier.dispose();
    _tileErrorNotifier.dispose();
    searchController.dispose();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _loadCurrentLocation() async {
    try {
      final latLng = await _service.getCurrentLocation();
      await _resolveAndUpdate(latLng);
    } on LocationServiceDisabledException {
      _statusNotifier.value = LocationPickerStatus.serviceDisabled;
    } on LocationPermissionDeniedException {
      _statusNotifier.value = LocationPickerStatus.permissionDenied;
    } catch (e) {
      _statusNotifier.value = LocationPickerStatus.locationError;
    }
  }

  /// Reverse-geocodes [latLng], stores the result, and notifies listeners.
  Future<void> _resolveAndUpdate(LatLng latLng) async {
    String? address;
    Placemark? placemark;

    try {
      address = await _service.getAddressFromLocation(latLng);
      placemark = await _service.getPlacemarkFromLocation(latLng);
    } on GeocodingException {
      // Surface this to the UI via status if needed in the future.
    }

    _result = _result.copyWith(
      location: latLng,
      address: address,
      clearAddress: address == null,
      placemark: placemark,
      clearPlacemark: placemark == null,
    );

    _locationNotifier.value = _result.location;
    _addressNotifier.value = _result.address;
  }
}
