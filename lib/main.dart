import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';

import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/models/qr_model_adapter.dart'
    show QRCodeModelAdapter;
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/services/hive_service.dart';
import 'package:qrcode_scanner_app/core/services/permission_service.dart';
import 'package:qrcode_scanner_app/core/services/settings_service.dart';
import 'package:qrcode_scanner_app/core/constants/app_theme.dart';
import 'package:qrcode_scanner_app/features/app_section/view/screens/app_section.dart';
import 'package:qrcode_scanner_app/features/details/view/screens/details_screen.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/generate_screen.dart';
import 'package:qrcode_scanner_app/features/history/view/screens/history_screen.dart';
import 'package:qrcode_scanner_app/features/scan/view/screens/scan_screen.dart';
import 'package:qrcode_scanner_app/features/settings/view/screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  await HiveService.instance.init(adapters: [QRCodeModelAdapter()]);
  await SettingsService.instance.load();
  await PermissionService.instance.init(
    requiredPermission: [Permission.camera],
    optionalPermission: [
      Permission.storage,
      Permission.notification,
      Permission.location,
    ],
  );
  runApp(const QRCodeScanner());
}

class QRCodeScanner extends StatelessWidget {
  const QRCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final s = SettingsService.instance;
    return ListenableBuilder(
      listenable: Listenable.merge([s.themeListener, s.languageListener]),
      builder: (_, _) => MaterialApp(
        navigatorObservers: [AppRoutes.routeObserver],
        debugShowCheckedModeBanner: false,
        initialRoute: QRCodeScannerApp.routeName,
        locale: s.language.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: s.supportedLocales.map((ele) => ele.locale),
        themeMode: s.theme.appTheme,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routes: {
          QRCodeScannerApp.routeName: (_) => const QRCodeScannerApp(),
          ScanScreen.routeName: (_) => const ScanScreen(),
          GenerateScreen.routeName: (_) => GenerateScreen(),
          HistoryScreen.routeName: (_) => const HistoryScreen(),
          SettingsScreen.routeName: (_) => const SettingsScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case DetailsScreen.routeName:
              return AppRoutes.pureNavigateRoute(
                DetailsScreen(qrData: settings.arguments as List<QRCodeModel>?),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
