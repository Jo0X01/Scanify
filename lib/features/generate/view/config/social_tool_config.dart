import 'package:qrcode_scanner_app/core/constants/app_assets.dart'
    show AppIcons;
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:qrcode_scanner_app/core/utils/validator.dart' show Validator;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show SocialType;
import 'package:qrcode_scanner_app/features/generate/view/config/tool_config.dart'
    show ToolConfig;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/social_controller.dart'
    show SocialController;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/social_template.dart'
    show SocialTemplate;

ToolConfig _social({
  required String icon,
  required String Function(AppLocalizations) title,
  required SocialType gDataType,
  required String Function(AppLocalizations) desc,
  required String? Function(String?, AppLocalizations) validator,
}) => ToolConfig(
  icon: icon,
  title: title,
  buildController: (l) => SocialController(
    title: title(l),
    usernameValidator: (val) => validator(val, l),
    iconSvgPath: icon,
    desc: desc(l),
    gType: gDataType,
  ),
  buildTemplate: (c) =>
      SocialTemplate(templateController: c as SocialController),
);

ToolConfig getSocialTool(SocialType val) => switch (val) {
  SocialType.whatsapp => _social(
    icon: AppIcons.whatsappIcon,
    title: (l) => l.whatsapp,
    desc: (l) => l.whatsappDesc,
    validator: (val, l) => Validator.validatePhoneNumber(val)?.message(l),
    gDataType: SocialType.whatsapp,
  ),

  SocialType.telegram => _social(
    icon: AppIcons.telegramIcon,
    title: (l) => l.telegram,
    desc: (l) => l.telegramDesc,
    validator: (val, l) => Validator.validateTelegram(val)?.message(l),
    gDataType: SocialType.telegram,
  ),

  SocialType.twitter => _social(
    icon: AppIcons.twitterIcon,
    title: (l) => l.twitter,
    desc: (l) => l.twitterDesc,
    validator: (val, l) => Validator.validateTwitter(val)?.message(l),
    gDataType: SocialType.twitter,
  ),

  SocialType.instagram => _social(
    icon: AppIcons.instagramIcon,
    title: (l) => l.instagram,
    desc: (l) => l.instagramDesc,
    validator: (val, l) => Validator.validateInstagram(val)?.message(l),
    gDataType: SocialType.instagram,
  ),

  SocialType.facebook => _social(
    icon: AppIcons.facebookIcon,
    title: (l) => l.facebook,
    desc: (l) => l.facebookDesc,
    validator: (val, l) => Validator.validateFacebook(val)?.message(l),
    gDataType: SocialType.facebook,
  ),

  SocialType.youtube => _social(
    icon: AppIcons.youtubeIcon,
    title: (l) => l.youtube,
    desc: (l) => l.youtubeDesc,
    validator: (val, l) => Validator.validateYoutube(val)?.message(l),
    gDataType: SocialType.youtube,
  ),

  SocialType.tiktok => _social(
    icon: AppIcons.tiktokIcon,
    title: (l) => l.tiktok,
    desc: (l) => l.tiktokDesc,
    validator: (val, l) => Validator.validateTikTok(val)?.message(l),
    gDataType: SocialType.tiktok,
  ),

  SocialType.paypal => _social(
    icon: AppIcons.paypalIcon,
    title: (l) => l.paypal,
    desc: (l) => l.paypalDesc,
    validator: (val, l) => Validator.validatePaypal(val)?.message(l),
    gDataType: SocialType.paypal,
  ),

  SocialType.snapchat => _social(
    icon: AppIcons.snapchatIcon,
    title: (l) => l.snapchat,
    desc: (l) => l.snapchatDesc,
    validator: (val, l) => Validator.validateSnapchat(val)?.message(l),
    gDataType: SocialType.snapchat,
  ),

  SocialType.spotify => _social(
    icon: AppIcons.spotifyIcon,
    title: (l) => l.spotify,
    desc: (l) => l.spotifyDesc,
    validator: (val, l) => Validator.validateSpotify(val)?.message(l),
    gDataType: SocialType.spotify,
  ),

  SocialType.linkedin => _social(
    icon: AppIcons.linkedinIcon,
    title: (l) => l.linkedIn,
    desc: (l) => l.linkedInDesc,
    validator: (val, l) => Validator.validateLinkedIn(val)?.message(l),
    gDataType: SocialType.linkedin,
  ),
};
