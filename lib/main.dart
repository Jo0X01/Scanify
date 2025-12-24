import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/utils/app_theme.dart';
import 'package:qrcode_scanner_app/features/app_section/app_section.dart';
import 'package:qrcode_scanner_app/features/details/view/screens/details_screen.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/generate_screen.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/wifi_screen.dart';
import 'package:qrcode_scanner_app/features/scan/view/screens/scan_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const QRCodeScanner());
}

class QRCodeScanner extends StatelessWidget {
  const QRCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: QRCodeScannerApp(),
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      routes: {
        AppRoutes.scanScreenRoute:(context) => ScanScreen(),
        AppRoutes.generateScreen:(context) => GenerateScreen(),
        AppRoutes.detailsScreen:(context) => DetailsScreen(),
        AppRoutes.wifiScreen:(context) => WifiScreen(),
      },
    );
  }
}
