import 'package:flutter/foundation.dart';

/// Minimal centralized error/log helper.
///
/// Right now this only prints to the debug console (visible in
/// `flutter run` / `adb logcat` / Xcode console), which is enough to see
/// what's failing during your own testing.
///
/// Before shipping to real users, wire a crash reporter here (Firebase
/// Crashlytics or Sentry are the common choices) so you get reports from
/// devices you don't control. Once you add one, this is the only file you
/// need to touch — every call site in the app already goes through here.
abstract class AppLogger {
  /// Logs a caught error. [context] should say what operation failed,
  /// e.g. "AppLogger.e('Failed to load current location', e, st)".
  static void log(String context, Object error, [StackTrace? stackTrace]) {
    if (kReleaseMode) {
      // TODO: send to Crashlytics / Sentry, e.g.:
      // FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: context);
    }
    
    if (stackTrace != null) {
      
    }
  }
}
