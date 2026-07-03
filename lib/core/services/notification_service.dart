import 'dart:convert' show utf8;
import 'dart:typed_data' show Uint8List, ByteData;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:crypto/crypto.dart' show sha256;

class AndroidNotificationEntry {
  final String? channelGroupKey;
  final String channelId;
  final String title;
  final String? desc;
  final bool? highImp;
  final bool? normalImp;
  final bool playSound;
  final bool enableVibration;
  final bool showBadge;
  final bool enableLights;

  const AndroidNotificationEntry({
    required this.channelId,
    this.channelGroupKey,
    required this.title,
    this.desc,
    this.highImp,
    this.normalImp,
    this.playSound = true,
    this.enableVibration = true,
    this.showBadge = true,
    this.enableLights = false,
  });
}

class NotificationService {
  static final instance = NotificationService._();
  NotificationService._();

  late final Map<String, AndroidNotificationEntry> _entries;
  late final Set<int> _activeIds;

  int _generateId(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    final buffer = Uint8List.fromList(digest.bytes.sublist(0, 8)).buffer;
    return ByteData.view(buffer).getUint64(0);
  }
  Future<void> init({
    required Map<String, String> groups,
    required List<AndroidNotificationEntry> entries,
  }) async {
    _activeIds = {};
    _entries = {};
    for (final e in entries) {
      _entries[e.channelId] = e;
    }
    await AwesomeNotifications().initialize(
      null,
      entries.map((e) {
        NotificationImportance importance = NotificationImportance.Low;
        if (e.highImp ?? false) importance = NotificationImportance.High;

        return NotificationChannel(
          channelGroupKey: e.channelGroupKey ?? groups.keys.first,
          channelKey: e.channelId,
          channelName: e.title,
          channelDescription: e.desc?.isNotEmpty == true ? e.desc : e.title,
          importance: importance,
          enableLights: e.enableLights,
          enableVibration: e.enableVibration,
          playSound: e.playSound,
          channelShowBadge: e.showBadge,
        );
      }).toList(),
      channelGroups: groups.entries
          .map(
            (ele) => NotificationChannelGroup(
              channelGroupKey: ele.key,
              channelGroupName: ele.value,
            ),
          )
          .toList(),
      debug: false,
    );
  }

  Future<void> requestPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> addEntries({
    required List<AndroidNotificationEntry> entries,
    bool create = false,
  }) async {
    for (final entry in entries) {
      await addEntry(entry: entry, create: create);
    }
  }

  Future<void> createEntries() async {
    for (final entry in _entries.values) {
      await createEntry(entry: entry);
    }
  }

  Future<void> addEntry({
    required AndroidNotificationEntry entry,
    bool create = false,
  }) async {
    _entries[entry.channelId] = entry;
    if (create) {
      await createEntry(entry: entry);
    }
  }

  Future<void> createEntry({required AndroidNotificationEntry entry}) async {
    NotificationImportance importance = NotificationImportance.Default;
    if (entry.highImp ?? false) {
      importance = NotificationImportance.High;
    } else if (entry.normalImp ?? false) {
      importance = NotificationImportance.Default;
    }

    // setChannel creates the channel if it doesn't exist, or updates it
    await AwesomeNotifications().setChannel(
      NotificationChannel(
        channelKey: entry.channelId,
        channelName: entry.title,
        channelDescription: entry.desc ?? '',
        importance: importance,
        enableLights: entry.enableLights,
        enableVibration: entry.enableVibration,
        playSound: entry.playSound,
        channelShowBadge: entry.showBadge,
      ),
    );
  }

  Future<int?> showNotification({
    required String channelId,
    required String title,
    required String body,
    bool ongoing = false,
    bool autoCancel = true,
    int? id,
  }) async {
    id = id ?? _generateId("$title _$body");
    final isShown = await _safeIsNotificationActive(id);
    if (isShown) return id;
    _activeIds.add(id);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelId,
        title: title,
        body: body,
        locked: ongoing,
        showWhen: false,
        notificationLayout: NotificationLayout.Default,
        autoDismissible: autoCancel,
      ),
    );
    return id;
  }

  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
    await AwesomeNotifications().resetGlobalBadge();
    _activeIds.remove(id);
  }

  Future<void> cancelAll() async {
    await AwesomeNotifications().cancelAll();
    _activeIds.clear();
  }

  Future<bool> _safeIsNotificationActive(int id) async {
    try {
      return await AwesomeNotifications().isNotificationActiveOnStatusBar(
        id: id,
      );
    } catch (e) {
      
      return false; // assume not shown, proceed to show it
    }
  }
}
