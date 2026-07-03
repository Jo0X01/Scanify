import 'package:scanify/core/l10n/app_localizations.dart';

enum PopularType {
  text,
  wifi,
  email,
  sms,
  phone,
  contact,
  event,
  website,
  location;

  static String category(AppLocalizations l) => l.popularCategory;

  String label(AppLocalizations l) => switch (this) {
    PopularType.text => l.text,
    PopularType.wifi => l.wifi,
    PopularType.email => l.email,
    PopularType.sms => l.sms,
    PopularType.phone => l.telephone,
    PopularType.contact => l.contact,
    PopularType.event => l.event,
    PopularType.website => l.website,
    PopularType.location => l.location,
  };
}

enum SocialType {
  twitter(hasPhone: false),
  whatsapp(hasUsername: false),
  instagram(hasPhone: false),
  facebook(hasPhone: false),
  telegram(hasPhone: false),
  youtube(hasPhone: false),
  tiktok(hasPhone: false),
  paypal(hasPhone: false),
  snapchat(hasPhone: false),
  spotify(hasPhone: false),
  linkedin(hasPhone: false);

  final bool hasPhone;
  final bool hasUsername;
  const SocialType({this.hasPhone = true, this.hasUsername = true});
  static String category(AppLocalizations l) => l.socialCategory;

  String label(AppLocalizations l) => switch (this) {
    SocialType.twitter => l.twitter,
    SocialType.whatsapp => l.whatsapp,
    SocialType.instagram => l.instagram,
    SocialType.facebook => l.facebook,
    SocialType.telegram => l.telegram,
    SocialType.youtube => l.youtube,
    SocialType.tiktok => l.tiktok,
    SocialType.paypal => l.paypal,
    SocialType.snapchat => l.snapchat,
    SocialType.spotify => l.spotify,
    SocialType.linkedin => l.linkedIn,
  };
}

enum BarcodeToolType {
  code128,
  code39,
  code93,
  codabar,
  dataMatrix,
  ean13,
  ean8,
  itf2of5,
  itf2of5WithChecksum,
  itf14,
  upcA,
  upcE,
  pdf417,
  aztec;

  static String category(AppLocalizations l) => l.barcodeCategory;

  String label(AppLocalizations l) => switch (this) {
    BarcodeToolType.code128 => l.code128Desc,
    BarcodeToolType.code39 => l.code39Desc,
    BarcodeToolType.code93 => l.code93Desc,
    BarcodeToolType.codabar => l.codabarDesc,
    BarcodeToolType.dataMatrix => l.dataMatrixDesc,
    BarcodeToolType.ean13 => l.ean13Desc,
    BarcodeToolType.ean8 => l.ean8Desc,
    BarcodeToolType.itf2of5 => l.itf2of5Desc,
    BarcodeToolType.itf2of5WithChecksum => l.itf2of5WithChecksumDesc,
    BarcodeToolType.itf14 => l.itf14Desc,
    BarcodeToolType.upcA => l.upcADesc,
    BarcodeToolType.upcE => l.upcEDesc,
    BarcodeToolType.pdf417 => l.pdf417Desc,
    BarcodeToolType.aztec => l.aztecDesc,
  };
}
