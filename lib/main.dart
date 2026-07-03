import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scanify/app/scanify_app.dart' show ScanifyApp;
import 'package:scanify/core/services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await SettingsService.instance.load();
  runApp(const ScanifyApp());
}
