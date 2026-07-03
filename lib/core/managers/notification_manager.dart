import 'package:scanify/core/constants/notification_constants.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/managers/scanner_manager.dart';
import 'package:scanify/core/services/notification_service.dart';
import 'package:scanify/core/services/route_service.dart' show RouteService;

class NotificationManager {
  static final instance = NotificationManager._();

  final NotificationService _notificationService;

  NotificationManager._() : _notificationService = NotificationService.instance;

  Future<void> notifyCameraState() async {
    final context = RouteService.rootScaffoldMessengerKey.currentContext;
    if (context == null) return;
    if (ScannerManager.instance.isCameraActive) {
      await _notificationService.showNotification(
        id: NotificationIds.camera,
        channelId: NotificationChannels.camera,
        title: context.l.notifCameraTitle,
        body: context.l.notifCameraBody,
        ongoing: true,
        autoCancel: false,
      );
    } else {
      await _notificationService.cancelNotification(NotificationIds.camera);
    }
  }

  Future<void> notifiyClearHistory() async {
    final context = RouteService.rootScaffoldMessengerKey.currentContext;
    if (context == null) return;
    await _notificationService.showNotification(
      id: NotificationIds.history,
      channelId: NotificationChannels.history,
      title: context.l.notifClearTitle,
      body: context.l.notifClearBody,
      ongoing: false,
      autoCancel: true,
    );
  }

  Future<void> notifiyDeleted() async {
    final context = RouteService.rootScaffoldMessengerKey.currentContext;
    if (context == null) return;
    await _notificationService.showNotification(
      id: NotificationIds.delete,
      channelId: NotificationChannels.history,
      title: context.l.notifDeleteTitle,
      body: context.l.notifDeleteBody,
      ongoing: false,
      autoCancel: true,
    );
  }

  Future<void> notifiyDeleteExpired() async {
    final context = RouteService.rootScaffoldMessengerKey.currentContext;
    if (context == null) return;
    await _notificationService.showNotification(
      id: NotificationIds.expired,
      channelId: NotificationChannels.history,
      title: context.l.notifDeleteExpiredTitle,
      body: context.l.notifDeleteExpiredBody,
      ongoing: false,
      autoCancel: true,
    );
  }

  Future<void> notifiySaved([int? counter]) async {
    final context = RouteService.rootScaffoldMessengerKey.currentContext;
    if (context == null) return;
    await _notificationService.showNotification(
      id: NotificationIds.save,
      channelId: NotificationChannels.save,
      title: context.l.notifSaveTitle + (counter != null ? "($counter)" : ""),
      body: context.l.notifSaveBody,
      ongoing: false,
      autoCancel: true,
    );
  }
}
