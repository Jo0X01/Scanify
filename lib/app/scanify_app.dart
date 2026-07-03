import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scanify/core/services/route_service.dart';

import 'package:scanify/core/l10n/app_localizations.dart';
import 'package:scanify/core/models/qrcode_model.dart';
import 'package:scanify/core/services/settings_service.dart';
import 'package:scanify/core/constants/app_theme.dart';
import 'package:scanify/features/app_section/screens/app_section.dart'
    show AppSectionScreen;
import 'package:scanify/features/details/view/screens/details_screen.dart';
import 'package:scanify/features/generate/view/screens/generate_screen.dart';
import 'package:scanify/features/history/view/screens/history_screen.dart';
import 'package:scanify/features/scan/view/screens/scan_screen.dart';
import 'package:scanify/features/settings/view/screens/settings_screen.dart';
import 'package:scanify/features/splash/view/screens/splash_screen.dart';

class ScanifyApp extends StatelessWidget {
  const ScanifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final s = SettingsService.instance;
    return ListenableBuilder(
      listenable: Listenable.merge([s.themeListener, s.languageListener]),
      builder: (_, _) => MaterialApp(
        scaffoldMessengerKey: RouteService.rootScaffoldMessengerKey,
        navigatorObservers: [RouteService.routeObserver],
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName.path,
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
          SplashScreen.routeName.path: (_) => const SplashScreen(),
          AppSectionScreen.routeName.path: (_) => const AppSectionScreen(),
          ScanScreen.routeName.path: (_) => const ScanScreen(),
          GenerateScreen.routeName.path: (_) => GenerateScreen(),
          HistoryScreen.routeName.path: (_) => const HistoryScreen(),
          SettingsScreen.routeName.path: (_) => const SettingsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == DetailsScreen.routeName.path) {
            return RouteService.pureNavigateRoute(
              DetailsScreen(qrData: settings.arguments as Set<QRCodeModel>?),
            );
          }
          return null;
        },
      ),
    );
  }
}
