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

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @ar.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get ar;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

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
  /// **'Choose your preferred theme'**
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

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the app display language'**
  String get languageSubtitle;

  /// No description provided for @amoled.
  ///
  /// In en, this message translates to:
  /// **'AMOLED True Black'**
  String get amoled;

  /// No description provided for @amoledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pure black background to save battery on OLED screens'**
  String get amoledSubtitle;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High Contrast'**
  String get highContrast;

  /// No description provided for @highContrastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Improve visibility with stronger text and icon contrast'**
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
  /// **'Automatically open results when a code is detected'**
  String get autoScanSubtitle;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @soundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Play a sound on a successful scan'**
  String get soundSubtitle;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @hapticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on a successful scan'**
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
  /// **'Newest First'**
  String get sortNewest;

  /// No description provided for @sortOldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest First'**
  String get sortOldest;

  /// No description provided for @sortAlphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get sortAlphabetical;

  /// No description provided for @sortFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites First'**
  String get sortFavorites;

  /// No description provided for @autoDelete.
  ///
  /// In en, this message translates to:
  /// **'Auto-Delete'**
  String get autoDelete;

  /// No description provided for @autoDeleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically remove scans older than the selected period'**
  String get autoDeleteSubtitle;

  /// No description provided for @autoDeleteNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get autoDeleteNever;

  /// No description provided for @autoDelete7.
  ///
  /// In en, this message translates to:
  /// **'After 7 days'**
  String get autoDelete7;

  /// No description provided for @autoDelete30.
  ///
  /// In en, this message translates to:
  /// **'After 30 days'**
  String get autoDelete30;

  /// No description provided for @autoDelete90.
  ///
  /// In en, this message translates to:
  /// **'After 90 days'**
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
  /// **'This will permanently delete all your scanned QR codes. This action cannot be undone.'**
  String get clearHistoryMessage;

  /// No description provided for @emptyHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No QR Codes Yet'**
  String get emptyHistoryTitle;

  /// No description provided for @emptyHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan or generate a QR code to see it here.'**
  String get emptyHistorySubtitle;

  /// No description provided for @emptySearchHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get emptySearchHistoryTitle;

  /// No description provided for @emptySearchHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'No QR codes match your current search or filters.'**
  String get emptySearchHistorySubtitle;

  /// No description provided for @askOnDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this QR code?'**
  String get askOnDeleteMessage;

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

  /// No description provided for @copyQrImage.
  ///
  /// In en, this message translates to:
  /// **'Copy as image'**
  String get copyQrImage;

  /// No description provided for @copyOriginalText.
  ///
  /// In en, this message translates to:
  /// **'Copy as data'**
  String get copyOriginalText;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at a QR or barcode'**
  String get scanHint;

  /// No description provided for @scanDetected.
  ///
  /// In en, this message translates to:
  /// **'Code detected!'**
  String get scanDetected;

  /// No description provided for @noBarCodeFoundInImageError.
  ///
  /// In en, this message translates to:
  /// **'No QR code or barcode found in the selected image'**
  String get noBarCodeFoundInImageError;

  /// No description provided for @noDataProvided.
  ///
  /// In en, this message translates to:
  /// **'No data provided.'**
  String get noDataProvided;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// No description provided for @generateQRCode.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Code / Barcode'**
  String get generateQRCode;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Code Details'**
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

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @twitter.
  ///
  /// In en, this message translates to:
  /// **'X (Twitter)'**
  String get twitter;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @telephone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
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
  /// **'WPA / WPA2'**
  String get wifiSecurityWPA;

  /// No description provided for @wifiSecurityWPA3.
  ///
  /// In en, this message translates to:
  /// **'WPA3'**
  String get wifiSecurityWPA3;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @sharing.
  ///
  /// In en, this message translates to:
  /// **'Sharing...'**
  String get sharing;

  /// No description provided for @sharedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Shared successfully'**
  String get sharedSuccessfully;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved to gallery'**
  String get savedSuccessfully;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save'**
  String get saveFailed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save'**
  String get saveError;

  /// No description provided for @shareError.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture the QR image'**
  String get shareError;

  /// No description provided for @qrErrorCorrectionLvL.
  ///
  /// In en, this message translates to:
  /// **'Error Correction Level'**
  String get qrErrorCorrectionLvL;

  /// No description provided for @qrErrorCorrectionLvLSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Higher levels recover more data if the code is damaged, but increase its complexity'**
  String get qrErrorCorrectionLvLSubtitle;

  /// No description provided for @qrErrorCorrectionLvLAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get qrErrorCorrectionLvLAuto;

  /// No description provided for @qrErrorCorrectionLowLvL.
  ///
  /// In en, this message translates to:
  /// **'Low — L (7%)'**
  String get qrErrorCorrectionLowLvL;

  /// No description provided for @qrErrorCorrectionMedLvL.
  ///
  /// In en, this message translates to:
  /// **'Medium — M (15%)'**
  String get qrErrorCorrectionMedLvL;

  /// No description provided for @qrErrorCorrectionQuartileLvL.
  ///
  /// In en, this message translates to:
  /// **'Quartile — Q (25%)'**
  String get qrErrorCorrectionQuartileLvL;

  /// No description provided for @qrErrorCorrectionHighLvL.
  ///
  /// In en, this message translates to:
  /// **'High — H (30%)'**
  String get qrErrorCorrectionHighLvL;

  /// No description provided for @showFullResultScan.
  ///
  /// In en, this message translates to:
  /// **'Show Full Scan Details'**
  String get showFullResultScan;

  /// No description provided for @showFullResultScanSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Display the complete decoded content and metadata of scanned codes'**
  String get showFullResultScanSubTitle;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In en, this message translates to:
  /// **'Last updated: 2026\n\nYour privacy matters. Here is how QR Scanner handles your data.\n\n1. Data Collection\nWe collect no personal data. All scanned QR codes are stored locally on your device and never leave it.\n\n2. Camera & Gallery Access\nCamera access is used only for scanning codes. Gallery access is used only when you choose to scan an image or save a code. Neither is recorded, transmitted, or shared.\n\n3. Third Parties\nWe use no analytics, advertising, or tracking services. No data is ever shared with third parties.\n\n4. Security\nAll data stays on your device. Your scan history is as secure as your device itself.\n\n5. Your Rights\nYou have full control over your data. You can delete your scan history at any time from Settings → Clear History.\n\n6. Contact\nFor questions about this policy, reach us at support@qrscanner.com'**
  String get privacyPolicyContent;

  /// No description provided for @aboutContent.
  ///
  /// In en, this message translates to:
  /// **'QR Scanner is a lightweight, privacy-first app built to make scanning and managing codes effortless.\n\nEvery scan is saved locally on your device — nothing is uploaded, tracked, or shared. Your data stays yours.'**
  String get aboutContent;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @savePath.
  ///
  /// In en, this message translates to:
  /// **'Save Location'**
  String get savePath;

  /// No description provided for @savePathSubtitle.
  ///
  /// In en, this message translates to:
  /// **'QR codes are saved to your gallery by default. Tap to choose a custom folder.'**
  String get savePathSubtitle;

  /// No description provided for @requireMissedPermissions.
  ///
  /// In en, this message translates to:
  /// **'Some permissions are required for the app to work properly. Please enable them in your device settings.'**
  String get requireMissedPermissions;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get permissionRequired;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open App Settings'**
  String get openSettings;

  /// No description provided for @permissionMessage.
  ///
  /// In en, this message translates to:
  /// **'This app needs certain permissions to work properly. Please enable them in Settings.'**
  String get permissionMessage;

  /// No description provided for @scanQrCodeOnly.
  ///
  /// In en, this message translates to:
  /// **'QR Codes Only'**
  String get scanQrCodeOnly;

  /// No description provided for @scanQrCodeOnlyContent.
  ///
  /// In en, this message translates to:
  /// **'Ignore all barcode formats and scan only QR codes.'**
  String get scanQrCodeOnlyContent;

  /// No description provided for @detectionClearTimeout.
  ///
  /// In en, this message translates to:
  /// **'Detection Timeout'**
  String get detectionClearTimeout;

  /// No description provided for @detectionClearTimeoutContent.
  ///
  /// In en, this message translates to:
  /// **'How long to wait before clearing a detected code after it leaves the camera view'**
  String get detectionClearTimeoutContent;

  /// No description provided for @after1Sec.
  ///
  /// In en, this message translates to:
  /// **'1s'**
  String get after1Sec;

  /// No description provided for @after5Sec.
  ///
  /// In en, this message translates to:
  /// **'5s'**
  String get after5Sec;

  /// No description provided for @after10Sec.
  ///
  /// In en, this message translates to:
  /// **'10s'**
  String get after10Sec;

  /// No description provided for @after15Sec.
  ///
  /// In en, this message translates to:
  /// **'15s'**
  String get after15Sec;

  /// No description provided for @after30Sec.
  ///
  /// In en, this message translates to:
  /// **'30s'**
  String get after30Sec;

  /// No description provided for @after1Min.
  ///
  /// In en, this message translates to:
  /// **'1m'**
  String get after1Min;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search codes...'**
  String get search;

  /// No description provided for @scanSource.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get scanSource;

  /// No description provided for @scanSourcePicked.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get scanSourcePicked;

  /// No description provided for @scanSourceScanned.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get scanSourceScanned;

  /// No description provided for @scanSourceGenerated.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get scanSourceGenerated;

  /// No description provided for @scanSourceUknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get scanSourceUknown;

  /// No description provided for @filterType.
  ///
  /// In en, this message translates to:
  /// **'Code Type'**
  String get filterType;

  /// No description provided for @typeText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get typeText;

  /// No description provided for @typeUrl.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get typeUrl;

  /// No description provided for @typeEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get typeEmail;

  /// No description provided for @typePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get typePhone;

  /// No description provided for @typeSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get typeSms;

  /// No description provided for @typeWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get typeWifi;

  /// No description provided for @typeContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get typeContact;

  /// No description provided for @typeLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get typeLocation;

  /// No description provided for @typeCalendarEvent.
  ///
  /// In en, this message translates to:
  /// **'Calendar Event'**
  String get typeCalendarEvent;

  /// No description provided for @typeProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get typeProduct;

  /// No description provided for @typeIsbn.
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get typeIsbn;

  /// No description provided for @typeDriverLicense.
  ///
  /// In en, this message translates to:
  /// **'Driver License'**
  String get typeDriverLicense;

  /// No description provided for @typeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get typeUnknown;

  /// No description provided for @filterFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get filterFormat;

  /// No description provided for @formatQrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get formatQrCode;

  /// No description provided for @formatUpcA.
  ///
  /// In en, this message translates to:
  /// **'UPC-A'**
  String get formatUpcA;

  /// No description provided for @formatUpcE.
  ///
  /// In en, this message translates to:
  /// **'UPC-E'**
  String get formatUpcE;

  /// No description provided for @formatEan13.
  ///
  /// In en, this message translates to:
  /// **'EAN-13'**
  String get formatEan13;

  /// No description provided for @formatEan8.
  ///
  /// In en, this message translates to:
  /// **'EAN-8'**
  String get formatEan8;

  /// No description provided for @formatCode128.
  ///
  /// In en, this message translates to:
  /// **'Code 128'**
  String get formatCode128;

  /// No description provided for @formatCode39.
  ///
  /// In en, this message translates to:
  /// **'Code 39'**
  String get formatCode39;

  /// No description provided for @formatCode93.
  ///
  /// In en, this message translates to:
  /// **'Code 93'**
  String get formatCode93;

  /// No description provided for @formatCodabar.
  ///
  /// In en, this message translates to:
  /// **'Codabar'**
  String get formatCodabar;

  /// No description provided for @formatPdf417.
  ///
  /// In en, this message translates to:
  /// **'PDF417'**
  String get formatPdf417;

  /// No description provided for @formatItf14.
  ///
  /// In en, this message translates to:
  /// **'ITF-14'**
  String get formatItf14;

  /// No description provided for @formatItf2of5.
  ///
  /// In en, this message translates to:
  /// **'ITF 2 of 5'**
  String get formatItf2of5;

  /// No description provided for @formatitf2of5WithChecksum.
  ///
  /// In en, this message translates to:
  /// **'ITF 2 of 5 with Checksum'**
  String get formatitf2of5WithChecksum;

  /// No description provided for @formatUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get formatUnknown;

  /// No description provided for @formatDataMatrix.
  ///
  /// In en, this message translates to:
  /// **'Data Matrix'**
  String get formatDataMatrix;

  /// No description provided for @formatAztec.
  ///
  /// In en, this message translates to:
  /// **'Aztec'**
  String get formatAztec;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @wifiEnterNetworkName.
  ///
  /// In en, this message translates to:
  /// **'Network Name (SSID)'**
  String get wifiEnterNetworkName;

  /// No description provided for @wifiEnterNetworkPassword.
  ///
  /// In en, this message translates to:
  /// **'Network Password'**
  String get wifiEnterNetworkPassword;

  /// No description provided for @wifiIsHiddenLabel.
  ///
  /// In en, this message translates to:
  /// **'Hidden Network'**
  String get wifiIsHiddenLabel;

  /// No description provided for @wifiSelectSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security Type'**
  String get wifiSelectSecurity;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactTitle;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get enterName;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get enterPhone;

  /// No description provided for @enterEmailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email Address (Optional)'**
  String get enterEmailOptional;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get enterEmail;

  /// No description provided for @enterWebsiteOptional.
  ///
  /// In en, this message translates to:
  /// **'Website URL (Optional)'**
  String get enterWebsiteOptional;

  /// No description provided for @enterCompanyOptional.
  ///
  /// In en, this message translates to:
  /// **'Company Name (Optional)'**
  String get enterCompanyOptional;

  /// No description provided for @subjectEnterOptional.
  ///
  /// In en, this message translates to:
  /// **'Subject (Optional)'**
  String get subjectEnterOptional;

  /// No description provided for @bodyEnterOptional.
  ///
  /// In en, this message translates to:
  /// **'Message Body (Optional)'**
  String get bodyEnterOptional;

  /// No description provided for @enterMessageBodyOptional.
  ///
  /// In en, this message translates to:
  /// **'Message Body (Optional)'**
  String get enterMessageBodyOptional;

  /// No description provided for @enterLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get enterLatitude;

  /// No description provided for @enterLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get enterLongitude;

  /// No description provided for @selectedAddressText.
  ///
  /// In en, this message translates to:
  /// **'Selected address will appear here — pick a location on the map to display it'**
  String get selectedAddressText;

  /// No description provided for @loadingCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Loading your location...'**
  String get loadingCurrentLocation;

  /// No description provided for @unknownLocation.
  ///
  /// In en, this message translates to:
  /// **'Unknown Location'**
  String get unknownLocation;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @pickLocation.
  ///
  /// In en, this message translates to:
  /// **'Pick Location'**
  String get pickLocation;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search by country, city, or address...'**
  String get searchLocation;

  /// No description provided for @pickMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use My Current Location'**
  String get pickMyLocation;

  /// No description provided for @locationServiceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location Services Disabled'**
  String get locationServiceDisabled;

  /// No description provided for @locationPermissionNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Not Granted'**
  String get locationPermissionNotGranted;

  /// No description provided for @pickMyLocationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Location loaded successfully'**
  String get pickMyLocationSuccess;

  /// No description provided for @locationDialogError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the map.\n\nPlease make sure:\n• Your internet connection is active\n• Location permission has been granted\n• Location services are turned on'**
  String get locationDialogError;

  /// No description provided for @enterWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website URL'**
  String get enterWebsite;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter your text here...'**
  String get enterText;

  /// No description provided for @popularCategory.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popularCategory;

  /// No description provided for @socialCategory.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get socialCategory;

  /// No description provided for @barcodeCategory.
  ///
  /// In en, this message translates to:
  /// **'Barcodes'**
  String get barcodeCategory;

  /// No description provided for @code128Desc.
  ///
  /// In en, this message translates to:
  /// **'High-density barcode for logistics, shipping, and inventory. Supports all ASCII characters.'**
  String get code128Desc;

  /// No description provided for @code39Desc.
  ///
  /// In en, this message translates to:
  /// **'Simple barcode for labels and industrial use. Supports numbers and uppercase letters.'**
  String get code39Desc;

  /// No description provided for @code93Desc.
  ///
  /// In en, this message translates to:
  /// **'A more compact and accurate version of Code 39.'**
  String get code93Desc;

  /// No description provided for @codabarDesc.
  ///
  /// In en, this message translates to:
  /// **'Legacy barcode format used in libraries, blood banks, and logistics.'**
  String get codabarDesc;

  /// No description provided for @dataMatrixDesc.
  ///
  /// In en, this message translates to:
  /// **'Compact 2D barcode for small items like electronics and medical labels.'**
  String get dataMatrixDesc;

  /// No description provided for @ean13Desc.
  ///
  /// In en, this message translates to:
  /// **'The standard retail barcode used on products worldwide.'**
  String get ean13Desc;

  /// No description provided for @ean8Desc.
  ///
  /// In en, this message translates to:
  /// **'A shorter EAN-13 for small packaging.'**
  String get ean8Desc;

  /// No description provided for @itf2of5Desc.
  ///
  /// In en, this message translates to:
  /// **'Industrial barcode for high-volume shipping and cartons.'**
  String get itf2of5Desc;

  /// No description provided for @itf2of5WithChecksumDesc.
  ///
  /// In en, this message translates to:
  /// **'ITF 2 of 5 with an added checksum for improved accuracy.'**
  String get itf2of5WithChecksumDesc;

  /// No description provided for @itf14Desc.
  ///
  /// In en, this message translates to:
  /// **'GS1-14 barcode for shipping containers and logistics units.'**
  String get itf14Desc;

  /// No description provided for @qrCodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Versatile 2D code that stores links, text, Wi-Fi credentials, contacts, and more.'**
  String get qrCodeDesc;

  /// No description provided for @upcADesc.
  ///
  /// In en, this message translates to:
  /// **'Standard retail barcode used across North America.'**
  String get upcADesc;

  /// No description provided for @upcEDesc.
  ///
  /// In en, this message translates to:
  /// **'A compressed UPC-A for small product packaging.'**
  String get upcEDesc;

  /// No description provided for @pdf417Desc.
  ///
  /// In en, this message translates to:
  /// **'Stacked 2D barcode used in IDs, transport tickets, and government documents.'**
  String get pdf417Desc;

  /// No description provided for @aztecDesc.
  ///
  /// In en, this message translates to:
  /// **'Compact 2D code used in boarding passes and transport tickets for fast scanning.'**
  String get aztecDesc;

  /// No description provided for @eventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// No description provided for @eventEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter event title'**
  String get eventEnterTitle;

  /// No description provided for @eventStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get eventStartDate;

  /// No description provided for @eventSelectStartDate.
  ///
  /// In en, this message translates to:
  /// **'Select start date'**
  String get eventSelectStartDate;

  /// No description provided for @eventEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get eventEndDate;

  /// No description provided for @eventSelectEndDate.
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get eventSelectEndDate;

  /// No description provided for @eventLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get eventLocation;

  /// No description provided for @eventEnterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter event location'**
  String get eventEnterLocation;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get eventDescription;

  /// No description provided for @eventEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter event description'**
  String get eventEnterDescription;

  /// No description provided for @enterJobOptional.
  ///
  /// In en, this message translates to:
  /// **'Job Title (Optional)'**
  String get enterJobOptional;

  /// No description provided for @enterAddressOptional.
  ///
  /// In en, this message translates to:
  /// **'Address (Optional)'**
  String get enterAddressOptional;

  /// No description provided for @enterNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (Optional)'**
  String get enterNoteOptional;

  /// No description provided for @twitterDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the X (Twitter) username without @. Example: openai'**
  String get twitterDesc;

  /// No description provided for @whatsappDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the phone number in international format including country code. You can optionally add a pre-filled message.'**
  String get whatsappDesc;

  /// No description provided for @instagramDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the Instagram username without @. Example: instagram'**
  String get instagramDesc;

  /// No description provided for @facebookDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the Facebook username or page name as it appears in the profile URL.'**
  String get facebookDesc;

  /// No description provided for @telegramDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the Telegram username or channel name without @. Example: durov'**
  String get telegramDesc;

  /// No description provided for @youtubeDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the YouTube channel handle without @. Example: YouTube'**
  String get youtubeDesc;

  /// No description provided for @tiktokDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the TikTok username without @. Example: tiktok'**
  String get tiktokDesc;

  /// No description provided for @paypalDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your PayPal username or PayPal.Me link name. Example: johndoe'**
  String get paypalDesc;

  /// No description provided for @snapchatDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the Snapchat username without spaces. Example: snapchat'**
  String get snapchatDesc;

  /// No description provided for @spotifyDesc.
  ///
  /// In en, this message translates to:
  /// **'Paste a Spotify profile, playlist, album, artist, or track URL.'**
  String get spotifyDesc;

  /// No description provided for @linkedInDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the LinkedIn profile username from your profile URL. Example: johndoe'**
  String get linkedInDesc;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @youtube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get youtube;

  /// No description provided for @tiktok.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get tiktok;

  /// No description provided for @paypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// No description provided for @snapchat.
  ///
  /// In en, this message translates to:
  /// **'Snapchat'**
  String get snapchat;

  /// No description provided for @spotify.
  ///
  /// In en, this message translates to:
  /// **'Spotify'**
  String get spotify;

  /// No description provided for @linkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedIn;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// No description provided for @validationNoAt.
  ///
  /// In en, this message translates to:
  /// **'Do not include the @ symbol'**
  String get validationNoAt;

  /// No description provided for @validationInvalidUsername.
  ///
  /// In en, this message translates to:
  /// **'Invalid username'**
  String get validationInvalidUsername;

  /// No description provided for @validationInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get validationInvalidPhone;

  /// No description provided for @validationInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get validationInvalidEmail;

  /// No description provided for @validationInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get validationInvalidUrl;

  /// No description provided for @validationInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters with one uppercase letter and one number'**
  String get validationInvalidPassword;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordMismatch;

  /// No description provided for @validationNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get validationNameEmpty;

  /// No description provided for @validationCodeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Code cannot be empty'**
  String get validationCodeEmpty;

  /// No description provided for @validationCodeTooShort.
  ///
  /// In en, this message translates to:
  /// **'Code must be at least 6 digits'**
  String get validationCodeTooShort;

  /// No description provided for @validationMessageTooLong.
  ///
  /// In en, this message translates to:
  /// **'Message cannot exceed 500 characters'**
  String get validationMessageTooLong;

  /// No description provided for @validationSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get validationSelectDate;

  /// No description provided for @validationLatitudeRequired.
  ///
  /// In en, this message translates to:
  /// **'Latitude is required'**
  String get validationLatitudeRequired;

  /// No description provided for @validationLatitudeNotNumber.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be a number'**
  String get validationLatitudeNotNumber;

  /// No description provided for @validationLatitudeOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -85 and 85'**
  String get validationLatitudeOutOfRange;

  /// No description provided for @validationLongitudeRequired.
  ///
  /// In en, this message translates to:
  /// **'Longitude is required'**
  String get validationLongitudeRequired;

  /// No description provided for @validationLongitudeNotNumber.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be a number'**
  String get validationLongitudeNotNumber;

  /// No description provided for @validationLongitudeOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180'**
  String get validationLongitudeOutOfRange;

  /// No description provided for @validationInvalidWepKey.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid WEP key'**
  String get validationInvalidWepKey;

  /// No description provided for @validationInvalidWpaKey.
  ///
  /// In en, this message translates to:
  /// **'Password must be 8–63 characters or exactly 64 hex characters'**
  String get validationInvalidWpaKey;

  /// No description provided for @validationValueRequired.
  ///
  /// In en, this message translates to:
  /// **'Value is required'**
  String get validationValueRequired;

  /// No description provided for @validationInvalidYoutube.
  ///
  /// In en, this message translates to:
  /// **'Invalid YouTube channel, handle, or video ID'**
  String get validationInvalidYoutube;

  /// No description provided for @validationInvalidPaypal.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid PayPal username or email'**
  String get validationInvalidPaypal;

  /// No description provided for @validationInvalidCode39.
  ///
  /// In en, this message translates to:
  /// **'Code 39 only supports A–Z, 0–9, and the characters - . space \$ / + %'**
  String get validationInvalidCode39;

  /// No description provided for @validationInvalidCodabar.
  ///
  /// In en, this message translates to:
  /// **'Codabar contains unsupported characters'**
  String get validationInvalidCodabar;

  /// No description provided for @validationInvalidEan13.
  ///
  /// In en, this message translates to:
  /// **'EAN-13 must be 12 or 13 digits'**
  String get validationInvalidEan13;

  /// No description provided for @validationInvalidEan8.
  ///
  /// In en, this message translates to:
  /// **'EAN-8 must be 7 or 8 digits'**
  String get validationInvalidEan8;

  /// No description provided for @validationInvalidItf.
  ///
  /// In en, this message translates to:
  /// **'ITF only supports digits'**
  String get validationInvalidItf;

  /// No description provided for @validationInvalidItfOddDigits.
  ///
  /// In en, this message translates to:
  /// **'ITF requires an even number of digits'**
  String get validationInvalidItfOddDigits;

  /// No description provided for @validationInvalidItf14.
  ///
  /// In en, this message translates to:
  /// **'ITF-14 must be 13 or 14 digits'**
  String get validationInvalidItf14;

  /// No description provided for @validationInvalidUpcA.
  ///
  /// In en, this message translates to:
  /// **'UPC-A must be 11 or 12 digits'**
  String get validationInvalidUpcA;

  /// No description provided for @validationInvalidUpcE.
  ///
  /// In en, this message translates to:
  /// **'UPC-E must be 6 to 8 digits'**
  String get validationInvalidUpcE;

  /// No description provided for @enterUsernameId.
  ///
  /// In en, this message translates to:
  /// **'Username or ID'**
  String get enterUsernameId;

  /// No description provided for @summaryInfo.
  ///
  /// In en, this message translates to:
  /// **'Code Info'**
  String get summaryInfo;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okay;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @dateUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get dateUnknown;

  /// No description provided for @dataLength.
  ///
  /// In en, this message translates to:
  /// **'Character Count'**
  String get dataLength;

  /// No description provided for @calendarSummary.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get calendarSummary;

  /// No description provided for @calendarLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get calendarLocation;

  /// No description provided for @calendarDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get calendarDescription;

  /// No description provided for @calendarStartDate.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get calendarStartDate;

  /// No description provided for @calendarEndDate.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get calendarEndDate;

  /// No description provided for @contactFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get contactFirstName;

  /// No description provided for @contactLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get contactLastName;

  /// No description provided for @contactOrganization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get contactOrganization;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get contactPhone;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get contactEmail;

  /// No description provided for @contactAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contactAddress;

  /// No description provided for @contactWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get contactWebsite;

  /// No description provided for @wifiSsid.
  ///
  /// In en, this message translates to:
  /// **'Network Name'**
  String get wifiSsid;

  /// No description provided for @wifiPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get wifiPassword;

  /// No description provided for @wifiEncryption.
  ///
  /// In en, this message translates to:
  /// **'Security Type'**
  String get wifiEncryption;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get emailAddress;

  /// No description provided for @emailSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get emailSubject;

  /// No description provided for @emailBody.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get emailBody;

  /// No description provided for @smsNumber.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get smsNumber;

  /// No description provided for @smsMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get smsMessage;

  /// No description provided for @geoLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get geoLatitude;

  /// No description provided for @geoLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get geoLongitude;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get phoneType;

  /// No description provided for @productBarcode.
  ///
  /// In en, this message translates to:
  /// **'Product Value'**
  String get productBarcode;

  /// No description provided for @enableHistory.
  ///
  /// In en, this message translates to:
  /// **'Enable History'**
  String get enableHistory;

  /// No description provided for @enableHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Save scanned QR codes locally on your device for easy access later.'**
  String get enableHistoryDesc;

  /// No description provided for @historyDisabled.
  ///
  /// In en, this message translates to:
  /// **'History is disabled. Enable it in Settings to view this page.'**
  String get historyDisabled;

  /// No description provided for @noWifiProtection.
  ///
  /// In en, this message translates to:
  /// **'Open Network'**
  String get noWifiProtection;

  /// No description provided for @notifCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera is ON'**
  String get notifCameraTitle;

  /// No description provided for @notifCameraBody.
  ///
  /// In en, this message translates to:
  /// **'Your camera is currently active'**
  String get notifCameraBody;

  /// No description provided for @notifSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Successfully'**
  String get notifSaveTitle;

  /// No description provided for @notifSaveBody.
  ///
  /// In en, this message translates to:
  /// **'QR code has been saved to history'**
  String get notifSaveBody;

  /// No description provided for @notifClearTitle.
  ///
  /// In en, this message translates to:
  /// **'History Cleared'**
  String get notifClearTitle;

  /// No description provided for @notifClearBody.
  ///
  /// In en, this message translates to:
  /// **'All QR codes have been removed'**
  String get notifClearBody;

  /// No description provided for @notifDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Item Deleted'**
  String get notifDeleteTitle;

  /// No description provided for @notifDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'QR code has been removed from history'**
  String get notifDeleteBody;

  /// No description provided for @notifDeleteExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Expired Items Removed'**
  String get notifDeleteExpiredTitle;

  /// No description provided for @notifDeleteExpiredBody.
  ///
  /// In en, this message translates to:
  /// **'Expired QR codes have been automatically deleted from history'**
  String get notifDeleteExpiredBody;

  /// No description provided for @initError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during initialization.'**
  String get initError;

  /// No description provided for @initSuccess.
  ///
  /// In en, this message translates to:
  /// **'Initialization completed successfully.'**
  String get initSuccess;

  /// No description provided for @initLoading.
  ///
  /// In en, this message translates to:
  /// **'Initializing...'**
  String get initLoading;
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
