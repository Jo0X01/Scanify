
enum AppRouteKeys {
  appRoute('/'),
  splashRoute("/splash"),
  scanScreen('/scan'),
  detailsScreen('/details'),
  generateScreen('/generate'),
  historyScreen('/history'),
  settingsScreen('/settings'),
  templateScreen('/generate-template');

  final String path;
  const AppRouteKeys(this.path);
}
