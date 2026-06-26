import 'dart:async';

import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;
import 'package:qrcode_scanner_app/core/enum/app_theme_mode.dart'
    show AppThemeMode;
import 'package:qrcode_scanner_app/core/enum/auto_clear_detection_delay.dart';
import 'package:qrcode_scanner_app/core/enum/auto_delete_history.dart';
import 'package:qrcode_scanner_app/core/enum/av_language.dart';
import 'package:qrcode_scanner_app/core/enum/qr_error_correction.dart';
import 'package:qrcode_scanner_app/core/helpers/pref_helper.dart'
    show PrefHelper;

final class _Keys {
  static const theme = 'theme';
  static const qrOnly = 'qrCodeOnly';
  static const autoClearDelay = "autoClearDelay";
  // static const savePath = 'savePath';
  static const language = 'language';
  static const autoScan = 'autoScan';
  static const sound = 'sound';
  static const haptics = 'haptics';
  static const autoDelete = 'autoDelete';
  static const qrGeneratedLvL = 'auto';
  static const fullResultText = "fullResultText";
}

class SettingsService extends ChangeNotifier {
  SettingsService._();
  static final SettingsService instance = SettingsService._();

  Future<void> load() async {
    await PrefHelper.load();

    _theme = ValueNotifier(AppThemeMode.system);
    _language = ValueNotifier(AvLanguages.system);
    _autoDelete = ValueNotifier(AutoDeleteDay.never);
    _qrErrorCorrectionLvL = ValueNotifier(QrErrorCorrectionLevel.auto);
    _autoClearDetection = ValueNotifier(AutoClearDetectionDelay.auto);

    _autoScan = ValueNotifier(false);
    _sound = ValueNotifier(true);
    _haptics = ValueNotifier(true);
    _showFullDetails = ValueNotifier(true);
    _qrCodeOnly = ValueNotifier(true);

    await setTheme(null,persist: false);
    await setLanguage(null,persist: false);
    await setAutoDeleteDay(null,persist: false);
    await setErrorCorrectionLvL(null,persist: false);
    await setAutoClearDetection(null,persist: false);
    await setAutoScan(null,persist: false);
    await setSound(null,persist: false);
    await setHaptics(null,persist: false);
    await setShowFullDetails(null,persist: false);
    await setScanQrCodeOnly(null,persist: false);
  }

  late ValueNotifier<AppThemeMode> _theme;
  late ValueNotifier<AvLanguages> _language;
  late ValueNotifier<AutoDeleteDay> _autoDelete;
  late ValueNotifier<QrErrorCorrectionLevel> _qrErrorCorrectionLvL;
  late ValueNotifier<AutoClearDetectionDelay> _autoClearDetection;

  late ValueNotifier<bool> _autoScan;
  late ValueNotifier<bool> _sound;
  late ValueNotifier<bool> _haptics;
  late ValueNotifier<bool> _showFullDetails;
  late ValueNotifier<bool> _qrCodeOnly;

  AppThemeMode get theme => _theme.value;
  ValueNotifier<AppThemeMode> get themeListener => _theme;
  Future<void> setTheme(AppThemeMode? value, {bool persist = true}) async {
    _theme.value = await PrefHelper.enumSetter(
      _Keys.theme,
      value ?? _theme.value,
      AppThemeMode.values,
      persist,
    );
  }

  AvLanguages get language => _language.value;
  ValueNotifier<AvLanguages> get languageListener => _language;
  List<AvLanguages> get supportedLocales => AvLanguages.values;
  Future<void> setLanguage(AvLanguages? value, {bool persist = true}) async {
    _language.value = await PrefHelper.enumSetter(
      _Keys.language,
      value ?? _language.value,
      AvLanguages.values,
      persist,
    );
  }

  AutoDeleteDay get autoDelete => _autoDelete.value;
  ValueNotifier<AutoDeleteDay> get autoDeleteListener => _autoDelete;
  Future<void> setAutoDeleteDay(AutoDeleteDay? value,{ bool persist = true}) async {
    _autoDelete.value = await PrefHelper.enumSetter(
      _Keys.autoDelete,
      value ?? _autoDelete.value,
      AutoDeleteDay.values,
      persist,
    );
  }

  QrErrorCorrectionLevel get errorCorrection => _qrErrorCorrectionLvL.value;
  ValueNotifier<QrErrorCorrectionLevel> get errorCorrectionListener =>
      _qrErrorCorrectionLvL;
  Future<void> setErrorCorrectionLvL(
    QrErrorCorrectionLevel? value,{
    bool persist = true,
  }) async {
    _qrErrorCorrectionLvL.value = await PrefHelper.enumSetter(
      _Keys.qrGeneratedLvL,
      value ?? _qrErrorCorrectionLvL.value,
      QrErrorCorrectionLevel.values,
      persist,
    );
  }

  AutoClearDetectionDelay get autoClearDetection => _autoClearDetection.value;
  ValueNotifier<AutoClearDetectionDelay> get autoClearDetectionListener =>
      _autoClearDetection;
  Future<void> setAutoClearDetection(
    AutoClearDetectionDelay? value,{
    bool persist = true,
  }) async {
    _autoClearDetection.value = await PrefHelper.enumSetter(
      _Keys.autoClearDelay,
      value ?? _autoClearDetection.value,
      AutoClearDetectionDelay.values,
      persist,
    );
  }

  bool get autoScan => _autoScan.value;
  ValueNotifier<bool> get autoScanListener => _autoScan;
  Future<void> setAutoScan(bool? value,{ bool persist = true}) async {
    _autoScan.value = await PrefHelper.boolSetter(
      _Keys.autoScan,
      value ?? _autoScan.value,
      persist,
    );
  }

  bool get sound => _sound.value;
  ValueNotifier<bool> get soundListener => _sound;
  Future<void> setSound(bool? value,{ bool persist = true}) async {
    _sound.value = await PrefHelper.boolSetter(
      _Keys.sound,
      value ?? _sound.value,
      persist,
    );
  }

  bool get haptics => _haptics.value;
  ValueNotifier<bool> get hapticsListener => _haptics;
  Future<void> setHaptics(bool? value,{ bool persist = true}) async {
    _haptics.value = await PrefHelper.boolSetter(
      _Keys.haptics,
      value ?? _haptics.value,
      persist,
    );
  }

  bool get showFullDetails => _showFullDetails.value;
  ValueNotifier<bool> get showFullDetailsListener => _showFullDetails;
  Future<void> setShowFullDetails(bool? value,{ bool persist = true}) async {
    _showFullDetails.value = await PrefHelper.boolSetter(
      _Keys.fullResultText,
      value ?? _showFullDetails.value,
      persist,
    );
  }

  bool get scanQrCodeOnly => _qrCodeOnly.value;
  ValueNotifier<bool> get qrCodeOnlyListener => _qrCodeOnly;
  Future<void> setScanQrCodeOnly(bool? value,{ bool persist = true}) async {
    _qrCodeOnly.value = await PrefHelper.boolSetter(
      _Keys.qrOnly,
      value ?? _qrCodeOnly.value,
      persist,
    );
  }
}
