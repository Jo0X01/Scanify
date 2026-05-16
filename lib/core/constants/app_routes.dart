import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/features/app_section/app_section.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/generate_screen.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/wifi_screen.dart';
import 'package:qrcode_scanner_app/features/history/view/screens/history_screen.dart';
import 'package:qrcode_scanner_app/features/scan/view/screens/scan_screen.dart';
import 'package:qrcode_scanner_app/features/settings/view/screens/settings_screen.dart';

abstract class AppRoutes {
  static const String appRoute = '/';
  static const String scanScreen = '/scan';
  static const String detailsScreen = '/details';
  static const String generateScreen = '/generate';
  static const String historyScreen = '/history';
  static const String settingsScreen = '/settings';

  static const String wifiScreen = '/generate/wifi';
  static const String businessScreen = '/generate/business';
  static const String contactScreen = '/generate/contact';
  static const String textScreen = '/generate/text';
  static const String twitterScreen = '/generate/twitter';
  static const String websiteScreen = '/generate/website';
  static const String whatsappScreen = '/generate/whatsapp';
  static const String telephoneScreen = '/generate/telephone';
  static const String locationScreen = '/generate/location';
  static const String instagramScreen = '/generate/instagram';
  static const String eventScreen = '/generate/event';
  static const String emailScreen = '/generate/email';

  static final Map<String, WidgetBuilder> routes = {
    appRoute: (_) => const QRCodeScannerApp(),
    scanScreen: (_) => const ScanScreen(),
    generateScreen: (_) => GenerateScreen(),
    historyScreen: (_) => const HistoryScreen(),
    settingsScreen: (_) => const SettingsScreen(),
    wifiScreen: (_) => const WifiScreen(),
    // businessScreen: (_) => const BusinessScreen(),
    // contactScreen: (_) => const ContactScreen(),
    // textScreen: (_) => const TextScreen(),
    // twitterScreen: (_) => const TwitterScreen(),
    // websiteScreen: (_) => const WebsiteScreen(),
    // whatsappScreen: (_) => const WhatsAppScreen(),
    // telephoneScreen: (_) => const TelephoneScreen(),
    // locationScreen: (_) => const LocationScreen(),
    // instagramScreen: (_) => const InstagramScreen(),
    // eventScreen: (_) => const EventScreen(),
    // emailScreen: (_) => const EmailScreen(),
  };

  static Future<T?> navigateTo<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> replaceWith<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(
      context,
    ).pushReplacementNamed<T, dynamic>(routeName, arguments: arguments);
  }

  static void goBack<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }
}
