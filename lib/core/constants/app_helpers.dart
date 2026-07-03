import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:external_path/external_path.dart';
import 'package:intl/intl.dart';
import 'package:scanify/core/constants/app_strings.dart';

abstract class AppHelpers {
  static String fixQRString(String pattern, Map<String, String> args) {
    return pattern.replaceAllMapped(RegExp(r'\{(\w+)\}'), (match) {
      final key = match.group(1)!;
      return args[key] ?? '';
    });
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String getCleanDate(int? millisecondsSinceEpoch) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    );
    return "${date.hour}:${date.minute}, ${date.day}/${date.month}/${date.year}";
  }



  static String getReadableDate(
    int? millisecondsSinceEpoch, {
    String? pattern = " EEE | HH:mm | dd/MM/yyyy",
    String? locale = 'en',
  }) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    );
    return DateFormat(pattern, locale).format(date);
  }

  static DateTime? getMillisFromReadableDate(
    String dateString, {
    String pattern = "EEE | HH:mm | dd/MM/yyyy",
    String locale = 'en',
  }) {
    try {
      return DateFormat(pattern, locale).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static bool isExpired(int date, int days) {
    final savedAt = DateTime.fromMillisecondsSinceEpoch(date);
    return DateTime.now().difference(savedAt).inDays >= days;
  }

  static int getQrMaxChars(int version, int errorLevel) {
    const capacityTable = {
      1: {0: 25, 1: 20, 2: 16, 3: 10},
      2: {0: 47, 1: 38, 2: 29, 3: 20},
      3: {0: 77, 1: 61, 2: 47, 3: 35},
      4: {0: 114, 1: 90, 2: 67, 3: 50},
      5: {0: 154, 1: 122, 2: 87, 3: 64},
      6: {0: 195, 1: 154, 2: 108, 3: 84},
      7: {0: 224, 1: 178, 2: 125, 3: 93},
      8: {0: 279, 1: 221, 2: 157, 3: 122},
      9: {0: 335, 1: 262, 2: 189, 3: 154},
      10: {0: 395, 1: 311, 2: 221, 3: 165},
      15: {0: 695, 1: 554, 2: 390, 3: 304},
      20: {0: 1084, 1: 852, 2: 596, 3: 470},
      25: {0: 1588, 1: 1260, 2: 876, 3: 690},
      40: {0: 2953, 1: 2331, 2: 1663, 3: 1273},
    };
    return capacityTable[version]?[errorLevel] ?? 2953;
  }

  static String safePath(String path) {
    return path
        .replaceAll('\\', '/')
        .replaceAll(RegExp(r'/+'), '/')
        .trimRight()
        .replaceAll(RegExp(r'/$'), '');
  }

  static Future<String> getDefaultSavePath({String? path}) async {
    if (path != null && path.endsWith(AppStrings.appTitle)) {
      return safePath(path);
    }
    final dcim = safePath(
      await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM,
      ),
    );
    final folder = Directory("$dcim/${AppStrings.appTitle}");
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder.path;
  }
}
