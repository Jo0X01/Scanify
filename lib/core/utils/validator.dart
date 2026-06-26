import 'package:qrcode_scanner_app/core/enum/validation_error.dart' show ValidationError;
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';

const String emailRegexString =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String passwordRegexString = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@]{6,}$';
const String urlRegexString = r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,}(\/.*)?$';

// ---------------------------------------------------------------------------
// Validators — pure logic, return ValidationError? not String?
// use toFormValidator(l) to convert to String? for TextFormField
// ---------------------------------------------------------------------------

abstract class Validator {
  // ---------------------------------------------------------------------------
  // Adapter — converts ValidationError? to String? for TextFormField
  // ---------------------------------------------------------------------------

  static String? Function(String?) toFormValidator(
    ValidationError? Function(String?) validator,
    AppLocalizations l,
  ) =>
      (val) => validator(val)?.message(l);

  // ---------------------------------------------------------------------------
  // Special cases — keep returning String? since they have extra params
  // ---------------------------------------------------------------------------

  static String? validateIgnoreEmpty(
    String? value,
    ValidationError? Function(String?) validateCallback,
    AppLocalizations l,
  ) {
    if (value == null || value.isEmpty) return null;
    return validateCallback(value)?.message(l);
  }

  static String? validateWifiPassword(
    String? password,
    String security,
    AppLocalizations l,
  ) {
    if (security == 'None') return null;
    password = password?.trim() ?? '';
    if (password.isEmpty) return ValidationError.required.message(l);
    if (security == 'WEP') {
      final isValid =
          password.length == 5 ||
          password.length == 13 ||
          RegExp(r'^[0-9A-Fa-f]{10}$').hasMatch(password) ||
          RegExp(r'^[0-9A-Fa-f]{26}$').hasMatch(password);
      return isValid ? null : ValidationError.invalidWepKey.message(l);
    }
    final is64Hex = RegExp(r'^[0-9A-Fa-f]{64}$').hasMatch(password);
    if ((password.length >= 8 && password.length <= 63) || is64Hex) return null;
    return ValidationError.invalidWpaKey.message(l);
  }

  static String? validateConfirmPassword(
    String? val,
    String? password,
    AppLocalizations l,
  ) {
    if (val == null || val.trim().isEmpty) {
      return ValidationError.required.message(l);
    }
    if (val != password) return ValidationError.passwordMismatch.message(l);
    return null;
  }

  // ---------------------------------------------------------------------------
  // Pure validators — return ValidationError?
  // ---------------------------------------------------------------------------

  static ValidationError? validateDate(DateTime? date) =>
      date == null ? ValidationError.selectDate : null;

  static ValidationError? validateContent(String? val) =>
      (val?.length ?? 0) > 500 ? ValidationError.messageTooLong : null;

  static ValidationError? validateUrl(String? val) {
    if (val == null || val.trim().isEmpty) return ValidationError.required;
    if (!RegExp(urlRegexString).hasMatch(val)) {
      return ValidationError.invalidUrl;
    }
    return null;
  }

  static ValidationError? validateLatitude(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidationError.latitudeRequired;
    }
    final lat = double.tryParse(value.trim());
    if (lat == null) return ValidationError.latitudeNotNumber;
    if (lat < -85.0 || lat > 85.0) return ValidationError.latitudeOutOfRange;
    return null;
  }

  static ValidationError? validateLongitude(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidationError.longitudeRequired;
    }
    final lng = double.tryParse(value.trim());
    if (lng == null) return ValidationError.longitudeNotNumber;
    if (lng < -180.0 || lng > 180.0) return ValidationError.longitudeOutOfRange;
    return null;
  }

  static ValidationError? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) return ValidationError.required;
    if (!RegExp(emailRegexString).hasMatch(val)) {
      return ValidationError.invalidEmail;
    }
    return null;
  }

  static ValidationError? validatePassword(String? val) {
    if (val == null || val.trim().isEmpty) return ValidationError.required;
    if (!RegExp(passwordRegexString).hasMatch(val)) {
      return ValidationError.invalidPassword;
    }
    return null;
  }

  static ValidationError? validateName(String? val) {
    if (val == null || val.isEmpty) return ValidationError.nameEmpty;
    return null;
  }

  static ValidationError? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) return ValidationError.required;
    final phone = value.trim().replaceAll(RegExp(r'[\s()-]'), '');
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
      return ValidationError.invalidPhone;
    }
    return null;
  }

  static ValidationError? validateCode(String? val) {
    if (val == null || val.isEmpty) return ValidationError.codeEmpty;
    if (val.length < 6) return ValidationError.codeTooShort;
    return null;
  }

  // ---------------------------------------------------------------------------
  // Social validators
  // ---------------------------------------------------------------------------

  static ValidationError? validateTwitter(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (val.startsWith('@')) return ValidationError.noAtSymbol;
    if (!RegExp(r'^[a-zA-Z0-9_]{1,15}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateInstagram(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (val.startsWith('@')) return ValidationError.noAtSymbol;
    if (!RegExp(r'^[a-zA-Z0-9_.]{1,30}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateTelegram(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (val.startsWith('@')) return ValidationError.noAtSymbol;
    if (!RegExp(r'^[a-zA-Z0-9_]{5,32}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateSnapchat(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (!RegExp(r'^[a-zA-Z0-9_\-]{3,15}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateTikTok(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (val.startsWith('@')) return ValidationError.noAtSymbol;
    if (!RegExp(r'^[a-zA-Z0-9_.]{1,24}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateLinkedIn(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (!RegExp(r'^[a-zA-Z0-9\-]{3,100}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateSpotify(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  static ValidationError? validateYoutube(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (val.startsWith('@')) return ValidationError.noAtSymbol;
    if (RegExp(r'^UC[a-zA-Z0-9_\-]{22}$').hasMatch(val)) return null;
    if (RegExp(r'^[a-zA-Z0-9_\-]{11}$').hasMatch(val)) return null;
    if (RegExp(r'^[a-zA-Z0-9_\-\.]{3,30}$').hasMatch(val)) return null;
    return ValidationError.invalidYoutube;
  }

  static ValidationError? validatePaypal(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    final isEmail = RegExp(r'^[\w\.\-]+@[\w\.\-]+\.\w+$').hasMatch(val);
    final isUsername = RegExp(r'^[a-zA-Z0-9]{6,20}$').hasMatch(val);
    if (!isEmail && !isUsername) return ValidationError.invalidPaypal;
    return null;
  }

  static ValidationError? validateFacebook(String? val) {
    if (val == null || val.isEmpty) return ValidationError.required;
    if (RegExp(r'^\d+$').hasMatch(val)) return null;
    if (val.contains('..')) return ValidationError.invalidUsername;
    if (val.startsWith('.') || val.endsWith('.')) {
      return ValidationError.invalidUsername;
    }
    if (!RegExp(r'^[a-zA-Z0-9.]{5,50}$').hasMatch(val)) {
      return ValidationError.invalidUsername;
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Barcode validators
  // ---------------------------------------------------------------------------

  static ValidationError? code128(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    return null;
  }

  static ValidationError? code39(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^[A-Z0-9\-\.\ \$\/\+\%]+$').hasMatch(value)) {
      return ValidationError.invalidCode39;
    }
    return null;
  }

  static ValidationError? code93(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    return null;
  }

  static ValidationError? codabar(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^[0-9\-\$:\/\.\+]+$').hasMatch(value)) {
      return ValidationError.invalidCodabar;
    }
    return null;
  }

  static ValidationError? dataMatrix(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    return null;
  }

  static ValidationError? ean13(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d{12,13}$').hasMatch(value)) {
      return ValidationError.invalidEan13;
    }
    return null;
  }

  static ValidationError? ean8(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d{7,8}$').hasMatch(value)) {
      return ValidationError.invalidEan8;
    }
    return null;
  }

  static ValidationError? itf2of5(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d+$').hasMatch(value)) return ValidationError.invalidItf;
    if (value.length.isOdd) return ValidationError.invalidItfOddDigits;
    return null;
  }

  static ValidationError? itf2of5WithChecksum(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d+$').hasMatch(value)) return ValidationError.invalidItf;
    return null;
  }

  static ValidationError? itf14(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d{13,14}$').hasMatch(value)) {
      return ValidationError.invalidItf14;
    }
    return null;
  }

  static ValidationError? upcA(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d{11,12}$').hasMatch(value)) {
      return ValidationError.invalidUpcA;
    }
    return null;
  }

  static ValidationError? upcE(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    if (!RegExp(r'^\d{6,8}$').hasMatch(value)) {
      return ValidationError.invalidUpcE;
    }
    return null;
  }

  static ValidationError? pdf417(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    return null;
  }

  static ValidationError? aztec(String? value) {
    if (value == null || value.isEmpty) return ValidationError.valueRequired;
    return null;
  }
}
