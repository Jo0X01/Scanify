import 'dart:developer' show log;
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();
  static final instance = PermissionService._();

  late final int sdkVersion;
  final Set<Permission> _missedPermissionsList = {};

  late final List<Permission> requiredPermission;
  late final List<Permission> optionalPermission;
  late final List<Permission> allPermission;
  late final ValueNotifier<bool> optionalPermsGrantedListener;
  late final ValueNotifier<bool> requiredPermsGrantedListener;
  late final ValueNotifier<bool> allPermsGrantedListener;

  Permission get _storage => Platform.isAndroid
      ? (sdkVersion >= 33 ? Permission.photos : Permission.storage)
      : Permission.photos;

  Future<void> init({
    required List<Permission> requiredPermission,
    required List<Permission> optionalPermission,
  }) async {
    if (!kIsWeb && Platform.isAndroid) {
      final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
      sdkVersion = android.version.sdkInt;
    } else {
      sdkVersion = 0;
    }
    optionalPermsGrantedListener = ValueNotifier(false);
    requiredPermsGrantedListener = ValueNotifier(false);
    allPermsGrantedListener = ValueNotifier(false);
    this.requiredPermission = requiredPermission;
    this.optionalPermission = optionalPermission;
    allPermission = requiredPermission + optionalPermission;
    await requestRequiredPermissions();
  }

  Future<void> requestRequiredPermissions() async {
    if (kIsWeb) return;
    for (Permission perm in requiredPermission) {
      if (await perm.isPermanentlyDenied) continue;
      if (!await perm.isGranted) await perm.request();
    }
  }

  Future<void> checkRequiredPermissions() async {
    if (kIsWeb) return;
    for (Permission perm in requiredPermission) {
      if (await perm.isPermanentlyDenied) _missedPermissionsList.add(perm);
      if (!await perm.isGranted) await perm.request();
    }
    await isAllPermsGranted;
  }

  Future<void> checkPermissions() async {
    if (kIsWeb) return;
    for (Permission perm in allPermission) {
      if (await perm.isPermanentlyDenied) continue;
      if (!await perm.isGranted) await perm.request();
    }
    await isAllPermsGranted;
  }

  Future<void> checkMissedPermissions() async {
    if (kIsWeb) return;
    _missedPermissionsList.clear();
    for (Permission perm in allPermission) {
      if (!await perm.isGranted) {
        _missedPermissionsList.add(perm);
      }
    }
  }

  String get missedPermissionsStr {
    if (_missedPermissionsList.isEmpty) return '';
    return _missedPermissionsList
        .map((perm) => perm.toString().split('.').last.toUpperCase())
        .join(', ');
  }

  List<String> get missedPermissionsStrList {
    return _missedPermissionsList
        .map((perm) => perm.toString().split('.').last.toUpperCase())
        .toList();
  }

  Set<Permission> get missedPermissions => _missedPermissionsList;

  Future<bool> get isAllPermsGranted async {
    allPermsGrantedListener.value =
        await isOptionalGranted && await isRequiredGranted;
    return allPermsGrantedListener.value;
  }

  Future<bool> get isOptionalGranted async {
    optionalPermsGrantedListener.value = await _isPermsGranted(
      optionalPermission,
    );
    return optionalPermsGrantedListener.value;
  }

  Future<bool> get isRequiredGranted async {
    requiredPermsGrantedListener.value = await _isPermsGranted(
      requiredPermission,
    );
    log(requiredPermsGrantedListener.value.toString());
    return requiredPermsGrantedListener.value;
  }

  Future<bool> _isPermsGranted(List<Permission> perms) async {
    for (final perm in perms) {
      final resolved = (perm == Permission.storage || perm == Permission.photos)
          ? _storage
          : perm;
      if (!await resolved.isGranted) {
        await resolved.request();
        return await resolved.isGranted;
      }
    }
    return true;
  }
}
