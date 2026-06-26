// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get system => 'System';

  @override
  String get ar => 'العربية';

  @override
  String get en => 'English';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSubtitle => 'Choose your preferred theme';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Choose the app display language';

  @override
  String get amoled => 'AMOLED True Black';

  @override
  String get amoledSubtitle =>
      'Pure black background to save battery on OLED screens';

  @override
  String get highContrast => 'High Contrast';

  @override
  String get highContrastSubtitle =>
      'Improve visibility with stronger text and icon contrast';

  @override
  String get scanning => 'Scanning';

  @override
  String get autoScan => 'Auto Scan';

  @override
  String get autoScanSubtitle =>
      'Automatically open results when a code is detected';

  @override
  String get sound => 'Sound';

  @override
  String get soundSubtitle => 'Play a sound on a successful scan';

  @override
  String get haptics => 'Haptics';

  @override
  String get hapticsSubtitle => 'Vibrate on a successful scan';

  @override
  String get camera => 'Camera';

  @override
  String get flashMode => 'Flash Mode';

  @override
  String get flashOff => 'Off';

  @override
  String get flashOn => 'On';

  @override
  String get flashAuto => 'Auto';

  @override
  String get flashTorch => 'Torch';

  @override
  String get zoom => 'Zoom';

  @override
  String get focusMode => 'Focus Mode';

  @override
  String get focusAuto => 'Auto';

  @override
  String get focusContinuous => 'Continuous';

  @override
  String get focusManual => 'Manual';

  @override
  String get history => 'History';

  @override
  String get sortBy => 'Sort By';

  @override
  String get sortNewest => 'Newest First';

  @override
  String get sortOldest => 'Oldest First';

  @override
  String get sortAlphabetical => 'Alphabetical';

  @override
  String get sortFavorites => 'Favorites First';

  @override
  String get autoDelete => 'Auto-Delete';

  @override
  String get autoDeleteSubtitle =>
      'Automatically remove scans older than the selected period';

  @override
  String get autoDeleteNever => 'Never';

  @override
  String get autoDelete7 => 'After 7 days';

  @override
  String get autoDelete30 => 'After 30 days';

  @override
  String get autoDelete90 => 'After 90 days';

  @override
  String get clearHistory => 'Clear All History';

  @override
  String get clearHistoryTitle => 'Clear all history?';

  @override
  String get clearHistoryMessage =>
      'This will permanently delete all your scanned QR codes. This action cannot be undone.';

  @override
  String get emptyHistoryTitle => 'No QR Codes Yet';

  @override
  String get emptyHistorySubtitle =>
      'Scan or generate a QR code to see it here.';

  @override
  String get emptySearchHistoryTitle => 'No Results Found';

  @override
  String get emptySearchHistorySubtitle =>
      'No QR codes match your current search or filters.';

  @override
  String get askOnDeleteMessage =>
      'Are you sure you want to permanently delete this QR code?';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get sendFeedback => 'Send Feedback';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get delete => 'Delete';

  @override
  String get share => 'Share';

  @override
  String get copy => 'Copy';

  @override
  String get copyQrImage => 'Copy as image';

  @override
  String get copyOriginalText => 'Copy as data';

  @override
  String get save => 'Save';

  @override
  String get scanHint => 'Point the camera at a QR or barcode';

  @override
  String get scanDetected => 'Code detected!';

  @override
  String get noBarCodeFoundInImageError =>
      'No QR code or barcode found in the selected image';

  @override
  String get noDataProvided => 'No data provided.';

  @override
  String get generate => 'Generate';

  @override
  String get generateQRCode => 'Generate QR Code / Barcode';

  @override
  String get details => 'Code Details';

  @override
  String get text => 'Text';

  @override
  String get website => 'Website';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get event => 'Event';

  @override
  String get contact => 'Contact';

  @override
  String get business => 'Business';

  @override
  String get location => 'Location';

  @override
  String get email => 'Email';

  @override
  String get sms => 'SMS';

  @override
  String get twitter => 'X (Twitter)';

  @override
  String get instagram => 'Instagram';

  @override
  String get telephone => 'Phone';

  @override
  String get wifiSecurityNone => 'None';

  @override
  String get wifiSecurityWEP => 'WEP';

  @override
  String get wifiSecurityWPA => 'WPA / WPA2';

  @override
  String get wifiSecurityWPA3 => 'WPA3';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get sharing => 'Sharing...';

  @override
  String get sharedSuccessfully => 'Shared successfully';

  @override
  String get saving => 'Saving...';

  @override
  String get savedSuccessfully => 'Saved to gallery';

  @override
  String get saveFailed => 'Failed to save';

  @override
  String get error => 'Error';

  @override
  String get saveError => 'Failed to save';

  @override
  String get shareError => 'Failed to capture the QR image';

  @override
  String get qrErrorCorrectionLvL => 'Error Correction Level';

  @override
  String get qrErrorCorrectionLvLSubtitle =>
      'Higher levels recover more data if the code is damaged, but increase its complexity';

  @override
  String get qrErrorCorrectionLvLAuto => 'Auto';

  @override
  String get qrErrorCorrectionLowLvL => 'Low — L (7%)';

  @override
  String get qrErrorCorrectionMedLvL => 'Medium — M (15%)';

  @override
  String get qrErrorCorrectionQuartileLvL => 'Quartile — Q (25%)';

  @override
  String get qrErrorCorrectionHighLvL => 'High — H (30%)';

  @override
  String get showFullResultScan => 'Show Full Scan Details';

  @override
  String get showFullResultScanSubTitle =>
      'Display the complete decoded content and metadata of scanned codes';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicyContent =>
      'Last updated: 2026\n\nYour privacy matters. Here is how QR Scanner handles your data.\n\n1. Data Collection\nWe collect no personal data. All scanned QR codes are stored locally on your device and never leave it.\n\n2. Camera & Gallery Access\nCamera access is used only for scanning codes. Gallery access is used only when you choose to scan an image or save a code. Neither is recorded, transmitted, or shared.\n\n3. Third Parties\nWe use no analytics, advertising, or tracking services. No data is ever shared with third parties.\n\n4. Security\nAll data stays on your device. Your scan history is as secure as your device itself.\n\n5. Your Rights\nYou have full control over your data. You can delete your scan history at any time from Settings → Clear History.\n\n6. Contact\nFor questions about this policy, reach us at support@qrscanner.com';

  @override
  String get aboutContent =>
      'QR Scanner is a lightweight, privacy-first app built to make scanning and managing codes effortless.\n\nEvery scan is saved locally on your device — nothing is uploaded, tracked, or shared. Your data stays yours.';

  @override
  String get agree => 'Agree';

  @override
  String get savePath => 'Save Location';

  @override
  String get savePathSubtitle =>
      'QR codes are saved to your gallery by default. Tap to choose a custom folder.';

  @override
  String get requireMissedPermissions =>
      'Some permissions are required for the app to work properly. Please enable them in your device settings.';

  @override
  String get loading => 'Loading...';

  @override
  String get permissionRequired => 'Permission Required';

  @override
  String get openSettings => 'Open App Settings';

  @override
  String get permissionMessage =>
      'This app needs certain permissions to work properly. Please enable them in Settings.';

  @override
  String get scanQrCodeOnly => 'QR Codes Only';

  @override
  String get scanQrCodeOnlyContent =>
      'Ignore all barcode formats and scan only QR codes.';

  @override
  String get detectionClearTimeout => 'Detection Timeout';

  @override
  String get detectionClearTimeoutContent =>
      'How long to wait before clearing a detected code after it leaves the camera view';

  @override
  String get after1Sec => '1s';

  @override
  String get after5Sec => '5s';

  @override
  String get after10Sec => '10s';

  @override
  String get after15Sec => '15s';

  @override
  String get after30Sec => '30s';

  @override
  String get after1Min => '1m';

  @override
  String get search => 'Search codes...';

  @override
  String get scanSource => 'Source';

  @override
  String get scanSourcePicked => 'Gallery';

  @override
  String get scanSourceScanned => 'Camera';

  @override
  String get scanSourceGenerated => 'Generated';

  @override
  String get scanSourceUknown => 'Unknown';

  @override
  String get filterType => 'Code Type';

  @override
  String get typeText => 'Text';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeEmail => 'Email';

  @override
  String get typePhone => 'Phone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contact';

  @override
  String get typeLocation => 'Location';

  @override
  String get typeCalendarEvent => 'Calendar Event';

  @override
  String get typeProduct => 'Product';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeDriverLicense => 'Driver License';

  @override
  String get typeUnknown => 'Unknown';

  @override
  String get filterFormat => 'Format';

  @override
  String get formatQrCode => 'QR Code';

  @override
  String get formatUpcA => 'UPC-A';

  @override
  String get formatUpcE => 'UPC-E';

  @override
  String get formatEan13 => 'EAN-13';

  @override
  String get formatEan8 => 'EAN-8';

  @override
  String get formatCode128 => 'Code 128';

  @override
  String get formatCode39 => 'Code 39';

  @override
  String get formatCode93 => 'Code 93';

  @override
  String get formatCodabar => 'Codabar';

  @override
  String get formatPdf417 => 'PDF417';

  @override
  String get formatItf14 => 'ITF-14';

  @override
  String get formatItf2of5 => 'ITF 2 of 5';

  @override
  String get formatitf2of5WithChecksum => 'ITF 2 of 5 with Checksum';

  @override
  String get formatUnknown => 'Unknown';

  @override
  String get formatDataMatrix => 'Data Matrix';

  @override
  String get formatAztec => 'Aztec';

  @override
  String get filter => 'Filter';

  @override
  String get apply => 'Apply';

  @override
  String get wifiEnterNetworkName => 'Network Name (SSID)';

  @override
  String get wifiEnterNetworkPassword => 'Network Password';

  @override
  String get wifiIsHiddenLabel => 'Hidden Network';

  @override
  String get wifiSelectSecurity => 'Security Type';

  @override
  String get contactTitle => 'Contact Information';

  @override
  String get enterName => 'Full Name';

  @override
  String get enterPhone => 'Phone Number';

  @override
  String get enterEmailOptional => 'Email Address (Optional)';

  @override
  String get enterEmail => 'Email Address';

  @override
  String get enterWebsiteOptional => 'Website URL (Optional)';

  @override
  String get enterCompanyOptional => 'Company Name (Optional)';

  @override
  String get subjectEnterOptional => 'Subject (Optional)';

  @override
  String get bodyEnterOptional => 'Message Body (Optional)';

  @override
  String get enterMessageBodyOptional => 'Message Body (Optional)';

  @override
  String get enterLatitude => 'Latitude';

  @override
  String get enterLongitude => 'Longitude';

  @override
  String get selectedAddressText =>
      'Selected address will appear here — pick a location on the map to display it';

  @override
  String get loadingCurrentLocation => 'Loading your location...';

  @override
  String get unknownLocation => 'Unknown Location';

  @override
  String get confirm => 'Confirm';

  @override
  String get pickLocation => 'Pick Location';

  @override
  String get searchLocation => 'Search by country, city, or address...';

  @override
  String get pickMyLocation => 'Use My Current Location';

  @override
  String get locationServiceDisabled => 'Location Services Disabled';

  @override
  String get locationPermissionNotGranted => 'Location Permission Not Granted';

  @override
  String get pickMyLocationSuccess => 'Location loaded successfully';

  @override
  String get locationDialogError =>
      'Unable to load the map.\n\nPlease make sure:\n• Your internet connection is active\n• Location permission has been granted\n• Location services are turned on';

  @override
  String get enterWebsite => 'Website URL';

  @override
  String get enterText => 'Enter your text here...';

  @override
  String get popularCategory => 'Popular';

  @override
  String get socialCategory => 'Social Media';

  @override
  String get barcodeCategory => 'Barcodes';

  @override
  String get code128Desc =>
      'High-density barcode for logistics, shipping, and inventory. Supports all ASCII characters.';

  @override
  String get code39Desc =>
      'Simple barcode for labels and industrial use. Supports numbers and uppercase letters.';

  @override
  String get code93Desc => 'A more compact and accurate version of Code 39.';

  @override
  String get codabarDesc =>
      'Legacy barcode format used in libraries, blood banks, and logistics.';

  @override
  String get dataMatrixDesc =>
      'Compact 2D barcode for small items like electronics and medical labels.';

  @override
  String get ean13Desc =>
      'The standard retail barcode used on products worldwide.';

  @override
  String get ean8Desc => 'A shorter EAN-13 for small packaging.';

  @override
  String get itf2of5Desc =>
      'Industrial barcode for high-volume shipping and cartons.';

  @override
  String get itf2of5WithChecksumDesc =>
      'ITF 2 of 5 with an added checksum for improved accuracy.';

  @override
  String get itf14Desc =>
      'GS1-14 barcode for shipping containers and logistics units.';

  @override
  String get qrCodeDesc =>
      'Versatile 2D code that stores links, text, Wi-Fi credentials, contacts, and more.';

  @override
  String get upcADesc => 'Standard retail barcode used across North America.';

  @override
  String get upcEDesc => 'A compressed UPC-A for small product packaging.';

  @override
  String get pdf417Desc =>
      'Stacked 2D barcode used in IDs, transport tickets, and government documents.';

  @override
  String get aztecDesc =>
      'Compact 2D code used in boarding passes and transport tickets for fast scanning.';

  @override
  String get eventTitle => 'Event Title';

  @override
  String get eventEnterTitle => 'Enter event title';

  @override
  String get eventStartDate => 'Start Date';

  @override
  String get eventSelectStartDate => 'Select start date';

  @override
  String get eventEndDate => 'End Date';

  @override
  String get eventSelectEndDate => 'Select end date';

  @override
  String get eventLocation => 'Location';

  @override
  String get eventEnterLocation => 'Enter event location';

  @override
  String get eventDescription => 'Description';

  @override
  String get eventEnterDescription => 'Enter event description';

  @override
  String get enterJobOptional => 'Job Title (Optional)';

  @override
  String get enterAddressOptional => 'Address (Optional)';

  @override
  String get enterNoteOptional => 'Note (Optional)';

  @override
  String get twitterDesc =>
      'Enter the X (Twitter) username without @. Example: openai';

  @override
  String get whatsappDesc =>
      'Enter the phone number in international format including country code. You can optionally add a pre-filled message.';

  @override
  String get instagramDesc =>
      'Enter the Instagram username without @. Example: instagram';

  @override
  String get facebookDesc =>
      'Enter the Facebook username or page name as it appears in the profile URL.';

  @override
  String get telegramDesc =>
      'Enter the Telegram username or channel name without @. Example: durov';

  @override
  String get youtubeDesc =>
      'Enter the YouTube channel handle without @. Example: YouTube';

  @override
  String get tiktokDesc =>
      'Enter the TikTok username without @. Example: tiktok';

  @override
  String get paypalDesc =>
      'Enter your PayPal username or PayPal.Me link name. Example: johndoe';

  @override
  String get snapchatDesc =>
      'Enter the Snapchat username without spaces. Example: snapchat';

  @override
  String get spotifyDesc =>
      'Paste a Spotify profile, playlist, album, artist, or track URL.';

  @override
  String get linkedInDesc =>
      'Enter the LinkedIn profile username from your profile URL. Example: johndoe';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get facebook => 'Facebook';

  @override
  String get telegram => 'Telegram';

  @override
  String get youtube => 'YouTube';

  @override
  String get tiktok => 'TikTok';

  @override
  String get paypal => 'PayPal';

  @override
  String get snapchat => 'Snapchat';

  @override
  String get spotify => 'Spotify';

  @override
  String get linkedIn => 'LinkedIn';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationNoAt => 'Do not include the @ symbol';

  @override
  String get validationInvalidUsername => 'Invalid username';

  @override
  String get validationInvalidPhone => 'Invalid phone number';

  @override
  String get validationInvalidEmail => 'Invalid email address';

  @override
  String get validationInvalidUrl => 'Invalid URL';

  @override
  String get validationInvalidPassword =>
      'Password must be at least 6 characters with one uppercase letter and one number';

  @override
  String get validationPasswordMismatch => 'Passwords do not match';

  @override
  String get validationNameEmpty => 'Name cannot be empty';

  @override
  String get validationCodeEmpty => 'Code cannot be empty';

  @override
  String get validationCodeTooShort => 'Code must be at least 6 digits';

  @override
  String get validationMessageTooLong => 'Message cannot exceed 500 characters';

  @override
  String get validationSelectDate => 'Please select a date';

  @override
  String get validationLatitudeRequired => 'Latitude is required';

  @override
  String get validationLatitudeNotNumber => 'Latitude must be a number';

  @override
  String get validationLatitudeOutOfRange =>
      'Latitude must be between -85 and 85';

  @override
  String get validationLongitudeRequired => 'Longitude is required';

  @override
  String get validationLongitudeNotNumber => 'Longitude must be a number';

  @override
  String get validationLongitudeOutOfRange =>
      'Longitude must be between -180 and 180';

  @override
  String get validationInvalidWepKey => 'Enter a valid WEP key';

  @override
  String get validationInvalidWpaKey =>
      'Password must be 8–63 characters or exactly 64 hex characters';

  @override
  String get validationValueRequired => 'Value is required';

  @override
  String get validationInvalidYoutube =>
      'Invalid YouTube channel, handle, or video ID';

  @override
  String get validationInvalidPaypal =>
      'Enter a valid PayPal username or email';

  @override
  String get validationInvalidCode39 =>
      'Code 39 only supports A–Z, 0–9, and the characters - . space \$ / + %';

  @override
  String get validationInvalidCodabar =>
      'Codabar contains unsupported characters';

  @override
  String get validationInvalidEan13 => 'EAN-13 must be 12 or 13 digits';

  @override
  String get validationInvalidEan8 => 'EAN-8 must be 7 or 8 digits';

  @override
  String get validationInvalidItf => 'ITF only supports digits';

  @override
  String get validationInvalidItfOddDigits =>
      'ITF requires an even number of digits';

  @override
  String get validationInvalidItf14 => 'ITF-14 must be 13 or 14 digits';

  @override
  String get validationInvalidUpcA => 'UPC-A must be 11 or 12 digits';

  @override
  String get validationInvalidUpcE => 'UPC-E must be 6 to 8 digits';

  @override
  String get enterUsernameId => 'Username or ID';

  @override
  String get summaryInfo => 'Code Info';

  @override
  String get okay => 'OK';

  @override
  String get date => 'Date';

  @override
  String get open => 'Open';

  @override
  String get dateUnknown => 'Unknown';

  @override
  String get dataLength => 'Character Count';

  @override
  String get calendarSummary => 'Title';

  @override
  String get calendarLocation => 'Location';

  @override
  String get calendarDescription => 'Description';

  @override
  String get calendarStartDate => 'Starts';

  @override
  String get calendarEndDate => 'Ends';

  @override
  String get contactFirstName => 'First Name';

  @override
  String get contactLastName => 'Last Name';

  @override
  String get contactOrganization => 'Organization';

  @override
  String get contactPhone => 'Phone Number';

  @override
  String get contactEmail => 'Email Address';

  @override
  String get contactAddress => 'Address';

  @override
  String get contactWebsite => 'Website';

  @override
  String get wifiSsid => 'Network Name';

  @override
  String get wifiPassword => 'Password';

  @override
  String get wifiEncryption => 'Security Type';

  @override
  String get emailAddress => 'Recipient';

  @override
  String get emailSubject => 'Subject';

  @override
  String get emailBody => 'Message';

  @override
  String get smsNumber => 'Recipient';

  @override
  String get smsMessage => 'Message';

  @override
  String get geoLatitude => 'Latitude';

  @override
  String get geoLongitude => 'Longitude';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneType => 'Type';

  @override
  String get productBarcode => 'Product Value';
}
