import 'package:qrcode_scanner_app/core/constants/app_assets.dart'
    show AppIcons;
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';

enum AppSectionScreens {
  generate(icon: AppIcons.generateIcon),
  scan(icon: AppIcons.scanIcon, center: true),
  history(icon: AppIcons.historyIcon);

  final String icon;
  final bool center;

  const AppSectionScreens({required this.icon, this.center = false});

  static AppSectionScreens get centerScreen => scan;
  static List<AppSectionScreens> get sideScreens => [generate, history];

  String label(AppLocalizations l) => switch(this) {
    AppSectionScreens.generate => l.generate,
    AppSectionScreens.scan => "Scan",
    AppSectionScreens.history => l.history,
  };
}
