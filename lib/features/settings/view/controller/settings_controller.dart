import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode_scanner_app/core/services/hive_service.dart';
import 'package:qrcode_scanner_app/core/services/permission_service.dart';
import 'package:qrcode_scanner_app/core/services/settings_service.dart';

class SettingsController {
  final SettingsService settings;
  final PermissionService _perms;
  final HiveService _hiveService;

  SettingsController()
    : settings = SettingsService.instance,
      _perms = PermissionService.instance,
      _hiveService = HiveService.instance;

  Future<bool> openSystemAppSettings() => openAppSettings();

  Future<void> checkPermissions() => _perms.checkPermissions();
  Future<void> clearHistory() => _hiveService.clear();
  ValueNotifier<bool> get missedPermsListener =>
      _perms.optionalPermsGrantedListener;

}
