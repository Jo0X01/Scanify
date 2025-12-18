import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/utils/app_theme.dart';
import 'package:qrcode_scanner_app/features/app_section/app_section.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QRCodeScanner());
}

class QRCodeScanner extends StatelessWidget {
  const QRCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: App(),
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
    );
  }
}
