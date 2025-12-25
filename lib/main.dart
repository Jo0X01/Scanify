import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qrcode_scanner_app/core/constants/app_hive.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/utils/app_theme.dart';
import 'package:qrcode_scanner_app/features/app_section/app_section.dart';
import 'package:qrcode_scanner_app/features/details/view/screens/details_screen.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/generate_screen.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/wifi_screen.dart';
import 'package:qrcode_scanner_app/features/history/view/screens/history_screen.dart';
import 'package:qrcode_scanner_app/features/scan/view/screens/scan_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (!Hive.isAdapterRegistered(HistoryQRCodeModelAdapter().typeId)) {
    Hive.registerAdapter(HistoryQRCodeModelAdapter());
  }

  try {
    await Hive.openBox<HistoryQRCodeModel>(AppHive.qrcodesBox);
  } on HiveError catch (_) {
    await Hive.deleteBoxFromDisk(AppHive.qrcodesBox);
    await Hive.openBox<HistoryQRCodeModel>(AppHive.qrcodesBox);
  }
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
        AppRoutes.scanScreenRoute: (context) => ScanScreen(),
        AppRoutes.generateScreen: (context) => GenerateScreen(),
        AppRoutes.detailsScreen: (context) => DetailsScreen(),
        AppRoutes.historyScreen: (context) => HistoryScreen(),
        AppRoutes.wifiScreen: (context) => WifiScreen(),
      },
    );
  }
}
