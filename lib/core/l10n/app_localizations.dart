import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred look'**
  String get themeSubtitle;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @amoled.
  ///
  /// In en, this message translates to:
  /// **'AMOLED True Black'**
  String get amoled;

  /// No description provided for @amoledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pure black background saves battery'**
  String get amoledSubtitle;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High Contrast'**
  String get highContrast;

  /// No description provided for @highContrastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Increases text and icon contrast'**
  String get highContrastSubtitle;

  /// No description provided for @scanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning'**
  String get scanning;

  /// No description provided for @autoScan.
  ///
  /// In en, this message translates to:
  /// **'Auto Scan'**
  String get autoScan;

  /// No description provided for @autoScanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Navigate instantly when a code is detected'**
  String get autoScanSubtitle;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @soundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Play a sound on successful scan'**
  String get soundSubtitle;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @hapticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on successful scan'**
  String get hapticsSubtitle;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @flashMode.
  ///
  /// In en, this message translates to:
  /// **'Flash Mode'**
  String get flashMode;

  /// No description provided for @flashOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get flashOff;

  /// No description provided for @flashOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get flashOn;

  /// No description provided for @flashAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get flashAuto;

  /// No description provided for @flashTorch.
  ///
  /// In en, this message translates to:
  /// **'Torch'**
  String get flashTorch;

  /// No description provided for @zoom.
  ///
  /// In en, this message translates to:
  /// **'Zoom'**
  String get zoom;

  /// No description provided for @focusMode.
  ///
  /// In en, this message translates to:
  /// **'Focus Mode'**
  String get focusMode;

  /// No description provided for @focusAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get focusAuto;

  /// No description provided for @focusContinuous.
  ///
  /// In en, this message translates to:
  /// **'Continuous'**
  String get focusContinuous;

  /// No description provided for @focusManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get focusManual;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Date (newest)'**
  String get sortNewest;

  /// No description provided for @sortOldest.
  ///
  /// In en, this message translates to:
  /// **'Date (oldest)'**
  String get sortOldest;

  /// No description provided for @sortAlphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get sortAlphabetical;

  /// No description provided for @sortFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites first'**
  String get sortFavorites;

  /// No description provided for @autoDelete.
  ///
  /// In en, this message translates to:
  /// **'Auto-delete'**
  String get autoDelete;

  /// No description provided for @autoDeleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove old scans automatically'**
  String get autoDeleteSubtitle;

  /// No description provided for @autoDeleteNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get autoDeleteNever;

  /// No description provided for @autoDelete7.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get autoDelete7;

  /// No description provided for @autoDelete30.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get autoDelete30;

  /// No description provided for @autoDelete90.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get autoDelete90;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear All History'**
  String get clearHistory;

  /// No description provided for @clearHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all history?'**
  String get clearHistoryTitle;

  /// No description provided for @clearHistoryMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all scanned QR codes.'**
  String get clearHistoryMessage;

  /// No description provided for @emptyHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No QR codes yet'**
  String get emptyHistoryTitle;

  /// No description provided for @emptyHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan or generate a QR code to get started'**
  String get emptyHistorySubtitle;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Align QR code within the frame'**
  String get scanHint;

  /// No description provided for @scanDetected.
  ///
  /// In en, this message translates to:
  /// **'QR Code found!'**
  String get scanDetected;

  /// No description provided for @noBarCodeFoundInImageError.
  ///
  /// In en, this message translates to:
  /// **'No Barcode/QR Code found in selected image'**
  String get noBarCodeFoundInImageError;

  /// No description provided for @noDataProvided.
  ///
  /// In en, this message translates to:
  /// **'No data provided.'**
  String get noDataProvided;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate QR'**
  String get generate;

  /// No description provided for @generateQRCode.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Code'**
  String get generateQRCode;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'QR Code Details'**
  String get details;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @wifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get wifi;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @twitter.
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get twitter;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @telephone.
  ///
  /// In en, this message translates to:
  /// **'Telephone'**
  String get telephone;

  /// No description provided for @wifiSecurityNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get wifiSecurityNone;

  /// No description provided for @wifiSecurityWEP.
  ///
  /// In en, this message translates to:
  /// **'WEP'**
  String get wifiSecurityWEP;

  /// No description provided for @wifiSecurityWPA.
  ///
  /// In en, this message translates to:
  /// **'WPA/WPA2'**
  String get wifiSecurityWPA;

  /// No description provided for @wifiSecurityWPA3.
  ///
  /// In en, this message translates to:
  /// **'WPA3'**
  String get wifiSecurityWPA3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
