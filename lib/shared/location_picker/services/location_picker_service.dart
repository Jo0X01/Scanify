import 'package:geocoding/geocoding.dart'
    show locationFromAddress, placemarkFromCoordinates, Placemark;
import 'package:geolocator/geolocator.dart'
    show Geolocator, LocationPermission, LocationSettings, LocationAccuracy;
import 'package:latlong2/latlong.dart' show LatLng;

import '../constants/map_constants.dart';
import '../exceptions/location_exceptions.dart';

/// Pure geo-services layer.
///
/// Every public method either returns a value or throws a typed
/// [LocationPickerException] — no silent nulls for failure paths.
/// Callers decide how to surface errors to the user.
class LocationPickerService {
  // ---------------------------------------------------------------------------
  // Map tile configuration (read by the controller / widget)
  // ---------------------------------------------------------------------------

  String get tileUrlTemplate => MapConstants.tileUrlTemplate;
  List<String> get tileSubdomains => MapConstants.tileSubdomains;

  // ---------------------------------------------------------------------------
  // Coordinate helpers
  // ---------------------------------------------------------------------------

  /// Clamps [latLng] to the valid tile-rendering bounds.
  LatLng clamp(LatLng latLng) => LatLng(
        latLng.latitude.clamp(-85.0, 85.0),
        latLng.longitude.clamp(-180.0, 180.0),
      );

  LatLng clampRaw(double lat, double lng) => clamp(LatLng(lat, lng));

  // ---------------------------------------------------------------------------
  // Permission & service checks
  // ---------------------------------------------------------------------------

  Future<bool> _isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<bool> _isPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Ensures location permission is granted and the service is enabled.
  ///
  /// Requests permission if not yet granted.
  /// Throws [LocationServiceDisabledException] or
  /// [LocationPermissionDeniedException] on failure.
  Future<void> ensureLocationAccess() async {
    if (!await _isPermissionGranted()) {
      await Geolocator.requestPermission();
    }

    if (!await _isServiceEnabled()) {
      throw const LocationServiceDisabledException();
    }

    if (!await _isPermissionGranted()) {
      throw const LocationPermissionDeniedException();
    }
  }

  // ---------------------------------------------------------------------------
  // Current device location
  // ---------------------------------------------------------------------------

  /// Returns the device's current [LatLng].
  ///
  /// Throws [LocationServiceDisabledException] or
  /// [LocationPermissionDeniedException] if access cannot be obtained.
  Future<LatLng> getCurrentLocation() async {
    await ensureLocationAccess();

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return clampRaw(position.latitude, position.longitude);
  }

  // ---------------------------------------------------------------------------
  // Geocoding
  // ---------------------------------------------------------------------------

  /// Converts a free-text [address] to a [LatLng].
  ///
  /// Throws [GeocodingException] if no result is found.
  Future<LatLng> getLocationFromAddress(String address) async {
    try {
      final results = await locationFromAddress(address);
      if (results.isEmpty) throw const GeocodingException('No results found.');
      final first = results.first;
      return clampRaw(first.latitude, first.longitude);
    } catch (e) {
      if (e is GeocodingException) rethrow;
      throw GeocodingException(e.toString());
    }
  }

  /// Reverse-geocodes [location] to a [Placemark].
  ///
  /// Returns `null` when [location] is `null` (convenience for optional coords).
  /// Throws [GeocodingException] on network / API failure.
  Future<Placemark?> getPlacemarkFromLocation(LatLng? location) async {
    if (location == null) return null;
    return _placemarkFromLatLng(location.latitude, location.longitude);
  }

  Future<Placemark?> _placemarkFromLatLng(double lat, double lng) async {
    try {
      final target = clampRaw(lat, lng);
      final results = await placemarkFromCoordinates(
        target.latitude,
        target.longitude,
      );
      return results.isEmpty ? null : results.first;
    } catch (e) {
      throw GeocodingException(e.toString());
    }
  }

  /// Reverse-geocodes [location] to a formatted address string.
  ///
  /// Returns `null` when [location] is `null`.
  /// Throws [GeocodingException] on failure.
  Future<String?> getAddressFromLocation(LatLng? location) async {
    if (location == null) return null;
    final target = clamp(location);
    return _addressFromLatLng(target.latitude, target.longitude);
  }

  Future<String?> _addressFromLatLng(double lat, double lng) async {
    try {
      final target = clampRaw(lat, lng);
      final results = await placemarkFromCoordinates(
        target.latitude,
        target.longitude,
      );
      if (results.isEmpty) return null;

      final p = results.first;
      final parts = [
        p.subLocality,
        p.subAdministrativeArea,
        p.locality,
        p.administrativeArea,
        p.country,
      ].where((e) => e != null && e.isNotEmpty);

      return parts.isEmpty ? null : parts.join(', ');
    } catch (e) {
      throw GeocodingException(e.toString());
    }
  }
}
