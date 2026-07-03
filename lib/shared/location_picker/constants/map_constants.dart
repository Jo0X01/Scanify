/// All hard-coded values for the location picker in one place.
/// Update the tile URL here if you ever switch map providers.
abstract final class MapConstants {
  // ---------------------------------------------------------------------------
  // Tile server
  // ---------------------------------------------------------------------------

  /// CartoDB "light_all" — clean, minimal basemap, free for reasonable traffic.
  static const String tileUrlTemplate =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png';

  static const List<String> tileSubdomains = ['a', 'b', 'c', 'd'];

  // ---------------------------------------------------------------------------
  // Camera defaults
  // ---------------------------------------------------------------------------

  static const double defaultZoom = 14.0;
  static const double minZoom = 3.0;
  static const double maxZoom = 18.0;

  // ---------------------------------------------------------------------------
  // UI strings (override via widget props where needed)
  // ---------------------------------------------------------------------------

  static const String defaultDialogTitle = 'Pick Location';
  static const String defaultLoadingText = 'Loading location…';
  static const String defaultConfirmText = 'Confirm';
  static const String searchHint = 'Search address…';
}
