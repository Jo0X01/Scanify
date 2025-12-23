abstract class AppHelpers {

  static String fixQRString(String pattern, Map<String, String> args) {
    return pattern.replaceAllMapped(RegExp(r'\{(\w+)\}'), (match) {
      final key = match.group(1)!;
      return args[key] ?? '';
    });
  }
}
