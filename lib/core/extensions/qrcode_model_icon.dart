import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:scanify/core/constants/app_assets.dart'
    show AppIcons;
import 'package:scanify/core/helpers/social_url_resolver.dart';
import 'package:scanify/core/models/qrcode_model.dart';
import 'package:scanify/core/enum/tool_data_types.dart'
    hide BarcodeToolType;

extension XQrModelIcon on QRCodeModel {
  String get icon => switch (type) {
    BarcodeType.unknown ||
    BarcodeType.product ||
    BarcodeType.isbn ||
    BarcodeType.driverLicense ||
    null => switch (format) {
      BarcodeFormat.qrCode ||
      BarcodeFormat.unknown ||
      BarcodeFormat.all ||
      null => AppIcons.appIcon,
      BarcodeFormat.code128 => AppIcons.code128Icon,
      BarcodeFormat.code39 => AppIcons.code39Icon,
      BarcodeFormat.code93 => AppIcons.code93Icon,
      BarcodeFormat.codabar => AppIcons.codabarIcon,
      BarcodeFormat.dataMatrix => AppIcons.dataMatrixIcon,
      BarcodeFormat.ean13 => AppIcons.ean13Icon,
      BarcodeFormat.ean8 => AppIcons.ean8Icon,
      BarcodeFormat.itf2of5 => AppIcons.itf2of5Icon,
      BarcodeFormat.itf2of5WithChecksum => AppIcons.itf2of5csIcon,
      // ignore: deprecated_member_use
      BarcodeFormat.itf14 || BarcodeFormat.itf => AppIcons.itf14Icon,
      BarcodeFormat.upcA => AppIcons.upcaIcon,
      BarcodeFormat.upcE => AppIcons.upc3Icon,
      BarcodeFormat.pdf417 => AppIcons.pdf417Icon,
      BarcodeFormat.aztec => AppIcons.aztecIcon,
    },
    BarcodeType.contactInfo => AppIcons.contactIcon,
    BarcodeType.email => AppIcons.emailIcon,
    BarcodeType.phone => AppIcons.telephoneIcon,
    BarcodeType.sms => AppIcons.smsIcon,
    BarcodeType.text => AppIcons.textIcon,
    BarcodeType.url => switch (SocialUrlResolver.detect(data)) {
      null => AppIcons.websiteIcon,
      SocialType.twitter => AppIcons.twitterIcon,
      SocialType.whatsapp => AppIcons.whatsappIcon,
      SocialType.instagram => AppIcons.instagramIcon,
      SocialType.facebook => AppIcons.facebookIcon,
      SocialType.telegram => AppIcons.telegramIcon,
      SocialType.youtube => AppIcons.youtubeIcon,
      SocialType.tiktok => AppIcons.tiktokIcon,
      SocialType.paypal => AppIcons.paypalIcon,
      SocialType.snapchat => AppIcons.snapchatIcon,
      SocialType.spotify => AppIcons.spotifyIcon,
      SocialType.linkedin => AppIcons.linkedinIcon,
    },
    BarcodeType.wifi => AppIcons.wifiIcon,
    BarcodeType.geo => AppIcons.locationIcon,
    BarcodeType.calendarEvent => AppIcons.eventIcon,
  };
}
