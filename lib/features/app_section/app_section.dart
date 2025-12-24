import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/features/app_section/widgets/custom_bottom_nav_bar.dart';
import 'package:qrcode_scanner_app/features/generate/view/screens/generate_screen.dart';
import 'package:qrcode_scanner_app/features/scan/view/screens/scan_screen.dart';

class QRCodeScannerApp extends StatefulWidget {
  const QRCodeScannerApp({super.key});
  static const routeName = AppRoutes.appRoute;

  @override
  State<QRCodeScannerApp> createState() => _QRCodeScannerAppState();
}

class _QRCodeScannerAppState extends State<QRCodeScannerApp> {
  int _currentIndex = 1;
  late final ScanScreen scanScreen;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    scanScreen =  ScanScreen();
    _screens = [
      GenerateScreen(),
      scanScreen,
      Scaffold()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onCenterTapped: scanScreen.captureNow,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
