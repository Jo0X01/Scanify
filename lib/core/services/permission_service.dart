import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();
  static final instance = PermissionService._();

  late final int sdkVersion;

  late final Set<Permission> requiredPermission;
  late final Set<Permission> optionalPermission;
  late final Set<Permission> allPermission;
  late final Set<Permission> missedPermissions;

  late final ValueNotifier<bool> optionalPermsGrantedListener;
  late final ValueNotifier<bool> requiredPermsGrantedListener;
  late final ValueNotifier<bool> allPermsGrantedListener;

  Permission get _storage => Platform.isAndroid
      ? (sdkVersion >= 33 ? Permission.photos : Permission.storage)
      : Permission.photos;

  Future<void> init({
    required List<Permission> requiredPermission,
    required List<Permission> optionalPermission,
    bool? request,
    bool? check,
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
    missedPermissions = {};
    this.requiredPermission = requiredPermission.toSet();
    this.optionalPermission = optionalPermission.toSet();
    allPermission = (requiredPermission + optionalPermission).toSet();
    if (request ?? true) {
      await requestRequiredPermissions();
    }
    if (check ?? true) {
      await checkAllPermissions();
    }
  }

  Future<bool> _permWorker({
    required Set<Permission> perms,
    bool saveIfMiss = false,
    bool requestIfNotGranted = false,
    bool checkIfAllGranted = false,
  }) async {
    if (kIsWeb) return false;
    if (saveIfMiss) missedPermissions.removeWhere(perms.contains);
    bool isAllGranted = true;
    for (Permission perm in perms) {
      perm = (perm == Permission.storage || perm == Permission.photos)
          ? _storage
          : perm;
      if (!await perm.isGranted) {
        if (requestIfNotGranted) {
          try {
            await perm.request();
          }
          // ignore: empty_catches
          catch (e) {}
        }
        if (!await perm.isGranted) {
          if (saveIfMiss) {
            missedPermissions.add(perm);
          }
          isAllGranted = false;
        }
      }
      if (checkIfAllGranted && isAllGranted) {
        isAllGranted = true;
      }
    }
    return isAllGranted;
  }

  Future<void> requestRequiredPermissions() async {
    await _permWorker(perms: requiredPermission, requestIfNotGranted: true);
  }

  Future<void> requestOptionalPermissions() async {
    await _permWorker(perms: optionalPermission, requestIfNotGranted: true);
  }

  Future<void> requestAllPermissions() async {
    await _permWorker(perms: allPermission, requestIfNotGranted: true);
  }

  Future<void> checkAllPermissions() async {
    await _permWorker(
      perms: allPermission,
      saveIfMiss: true,
      requestIfNotGranted: false,
    );
  }

  Future<void> checkRequiredPermissions() async {
    await _permWorker(
      perms: requiredPermission,
      saveIfMiss: true,
      requestIfNotGranted: false,
    );
  }

  Future<void> checkOptionalPermissions() async {
    await _permWorker(
      perms: optionalPermission,
      saveIfMiss: true,
      requestIfNotGranted: false,
    );
  }

  Future<bool> get isAllGranted async => await _permWorker(
    perms: allPermission,
    saveIfMiss: true,
    requestIfNotGranted: false,
    checkIfAllGranted: true,
  );
  Future<bool> get isRequiredGranted async => await _permWorker(
    perms: requiredPermission,
    saveIfMiss: true,
    requestIfNotGranted: false,
    checkIfAllGranted: true,
  );
  Future<bool> get isOptionalGranted async => await _permWorker(
    perms: optionalPermission,
    saveIfMiss: true,
    requestIfNotGranted: false,
    checkIfAllGranted: true,
  );

  String missedPermissionsAsStr({String sep = ","}) {
    if (missedPermissions.isEmpty) return '';
    return missedPermissions
        .map((perm) => perm.toString().split('.').last.toUpperCase())
        .join(', ');
  }

  Future<void> updateListeners() async {
    optionalPermsGrantedListener.value = await isOptionalGranted;
    requiredPermsGrantedListener.value = await isRequiredGranted;
    allPermsGrantedListener.value =
        optionalPermsGrantedListener.value &&
        requiredPermsGrantedListener.value;
  }

  // specific
  Future<bool> get isCameraGranted => _permWorker(
    perms: {Permission.camera},
    saveIfMiss: false,
    requestIfNotGranted: true,
    checkIfAllGranted: true,
  );
}
