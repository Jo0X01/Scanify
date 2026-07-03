import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constants/map_constants.dart';
import '../controller/location_picker_controller.dart';
import '../models/location_picker_result.dart';
import 'address_bar.dart';
import 'map_action_buttons.dart';
import 'map_placeholder.dart';
import 'tile_error_overlay.dart';

/// Embeddable map widget for picking (or displaying) a geographic location.
///
/// **Usage — interactive:**
/// ```dart
/// LocationPickerMapWidget(
///   initialValue: LocationPickerResult(),
///   onSelectPosition: (result) => print(result),
/// )
/// ```
///
/// **Usage — read-only:**
/// ```dart
/// LocationPickerMapWidget(
///   initialValue: myResult,
///   readOnly: true,
/// )
/// ```
class LocationPickerMapWidget extends StatefulWidget {
  const LocationPickerMapWidget({
    super.key,
    this.initialValue,
    this.readOnly = false,
    this.autoLoadIfEmpty = true,
    this.showSearchBar = true,
    this.showLocationBtn = true,
    this.onSelectPosition,
    this.onLoading,
    this.onLoad,
    this.tileUrl,
    this.tileSubdomains,
    this.dialogTitle,
    this.loadingText,
    this.confirmText,
    this.searchHint,
    this.errorMsg
  });

  /// localization
  final String? errorMsg;
  final String? dialogTitle;
  final String? loadingText;
  final String? confirmText;
  final String? searchHint;

  /// constants
  final String? tileUrl;
  final List<String>? tileSubdomains;

  /// ui customize
  final Widget? onLoading;

  /// The location (and optional address) to show when the widget first opens.
  final LocationPickerResult? initialValue;

  /// When `true`, the map cannot be tapped and action buttons are hidden.
  final bool readOnly;

  /// When `true` (default), the widget automatically fetches the device's
  /// current location if [initialValue] has no coordinate.
  final bool autoLoadIfEmpty;

  /// Shows / hides the address search bar.
  final bool? showSearchBar;

  /// Shows / hides the "my location" and "go to pin" FABs.
  final bool? showLocationBtn;

  /// Called every time the user picks a location (tap or GPS button).
  final void Function(LocationPickerResult)? onSelectPosition;

  /// Called once after the initial location load completes.
  final void Function(LocationPickerResult)? onLoad;

  @override
  State<LocationPickerMapWidget> createState() =>
      _LocationPickerMapWidgetState();
}

class _LocationPickerMapWidgetState extends State<LocationPickerMapWidget> {
  late final LocationPickerController _controller;

  /// Drives the [FutureBuilder] that guards against using the controller before
  /// async setup has completed. This fixes the original crash where `_setup()`
  /// was called without `await` in `initState`.
  late final Future<void> _setupFuture;

  @override
  void initState() {
    super.initState();
    _controller = LocationPickerController(
      initialValue: widget.initialValue,
      onSelectPosition: widget.onSelectPosition,
    );
    _setupFuture = _setup();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _setup() async {
    if (!widget.autoLoadIfEmpty) return;
    await _controller.loadCurrentLocationIfEmpty();
    widget.onLoad?.call(_controller.result);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _setupFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoading ??
              const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            if ((widget.showSearchBar ?? true) && !widget.readOnly)
              _buildSearchBar(),
            Expanded(child: _buildMap(widget.errorMsg)),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    final theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(minHeight: 60),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.tertiary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SearchBar(
        controller: _controller.searchController,
        hintText: widget.searchHint ?? MapConstants.searchHint,
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        scrollPadding: EdgeInsets.zero,
        leading: IconButton(
          icon: const Icon(Icons.search, size: 22),
          onPressed: _controller.searchAddress,
        ),
        hintStyle: WidgetStatePropertyAll(theme.textTheme.labelSmall),
        textStyle: WidgetStatePropertyAll(theme.textTheme.labelMedium),
        onSubmitted: (_) => _controller.searchAddress(),
      ),
    );
  }

  Widget _buildMap(String? errorMsg) {
    return ValueListenableBuilder<LatLng?>(
      valueListenable: _controller.locationNotifier,
      builder: (context, location, _) {
        if (location == null) {
          return MapPlaceholder(message: errorMsg);
        }
        return Stack(
          children: [
            _buildFlutterMap(location),
            if (!widget.readOnly && (widget.showLocationBtn ?? true))
              MapActionButtons(
                onBringMeHere: _controller.bringMeToCurrentLocation,
                onGoToPin: _controller.goToCurrentLocation,
                onZoomIn: _controller.zoomIn,
                onZoomOut: _controller.zoomOut,
              ),
            ValueListenableBuilder<bool>(
              valueListenable: _controller.tileErrorNotifier,
              builder: (_, tilesErrored, _) => tilesErrored
                  ? const TileErrorOverlay()
                  : const SizedBox.shrink(),
            ),
            ValueListenableBuilder<String?>(
              valueListenable: _controller.addressNotifier,
              builder: (_, address, _) => AddressBar(address: address),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlutterMap(LatLng initialCenter) {
    return FlutterMap(
      mapController: _controller.mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: MapConstants.defaultZoom,
        minZoom: MapConstants.minZoom,
        maxZoom: MapConstants.maxZoom,
        onTap: widget.readOnly ? null : _controller.onMapTap,
        interactionOptions: InteractionOptions(
          flags: widget.readOnly ? InteractiveFlag.none : InteractiveFlag.all,
        ),
        onMapReady: _controller.onMapReady,
      ),
      children: [
        TileLayer(
          urlTemplate: widget.tileUrl ?? MapConstants.tileUrlTemplate,
          // Resolved at build-time from the service via the controller.
          // Ignored fields below are populated by the controller.
          subdomains: widget.tileSubdomains ?? MapConstants.tileSubdomains,
          errorTileCallback: (_, _, _) => _controller.onTileError(),
          tileProvider: NetworkTileProvider(
            cachingProvider: BuiltInMapCachingProvider.getOrCreateInstance(),
          ),
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: initialCenter,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
