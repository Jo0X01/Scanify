import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanify/core/managers/notification_manager.dart';
import 'package:scanify/core/services/hive_service.dart';
import 'package:scanify/core/services/permission_service.dart';
import 'package:scanify/core/services/settings_service.dart';

class SettingsController {
  final SettingsService settings;
  final PermissionService _perms;
  final HiveService _hiveService;

  final ValueNotifier<bool> permWarnListener;

  SettingsController()
    : settings = SettingsService.instance,
      _perms = PermissionService.instance,
      _hiveService = HiveService.instance,
      permWarnListener = ValueNotifier(true);

  Future<bool> openSystemAppSettings() => openAppSettings();

  Future<void> checkPermissions() async {
    permWarnListener.value = await _perms.isOptionalGranted;
  }

  Future<void> clearHistory() async {
    await _hiveService.clear();
    NotificationManager.instance.notifiyClearHistory();
  }
}
