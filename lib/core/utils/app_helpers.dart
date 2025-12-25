import 'dart:convert';
import 'package:crypto/crypto.dart';

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

}
