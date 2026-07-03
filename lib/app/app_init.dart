
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanify/core/constants/notification_constants.dart';
import 'package:scanify/core/models/qr_model_adapter.dart';
import 'package:scanify/core/services/hive_service.dart';
import 'package:scanify/core/services/notification_service.dart';
import 'package:scanify/core/services/permission_service.dart';

abstract class AppInit {
  static Future<bool> init() async {
    try {
      await HiveService.instance.init(
        boxName:
            '102c2b93bfe65a2f45cda4af7288767428e120b9222d866539bddb5183b498a8',
        adapters: [QRCodeModelAdapter()],
      );
      await PermissionService.instance.init(
        request: true,
        check: true,
        requiredPermission: [Permission.notification, Permission.camera],
        optionalPermission: [Permission.storage, Permission.location],
      );
      await NotificationService.instance.init(
        groups: {"G1": "General"},
        entries: const [
          AndroidNotificationEntry(
            channelId: NotificationChannels.camera,
            title: NotificationTitles.camera,
            desc: NotificationTitles.cameraDesc,
          ),
          AndroidNotificationEntry(
            channelId: NotificationChannels.history,
            title: NotificationTitles.history,
            desc: NotificationTitles.historyDesc,
          ),
          AndroidNotificationEntry(
            channelId: NotificationChannels.save,
            title: NotificationTitles.save,
            desc: NotificationTitles.saveDesc,
          ),
        ],
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
