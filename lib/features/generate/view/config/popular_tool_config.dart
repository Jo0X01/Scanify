import 'package:qrcode_scanner_app/core/constants/app_assets.dart'
    show AppIcons;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:qrcode_scanner_app/features/generate/view/config/tool_config.dart'
    show ToolConfig;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/contact_controller.dart'
    show ContactController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/email_controller.dart'
    show EmailController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/event_controller.dart'
    show EventController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/location_controller.dart'
    show LocationController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/phone_controller.dart'
    show PhoneController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/sms_controller.dart'
    show SmsController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/text_controller.dart'
    show TextController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/website_controller.dart'
    show WebsiteController;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/wifi_controller.dart'
    show WifiController;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/contact_template.dart'
    show ContactTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/email_template.dart'
    show EmailTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/event_template.dart'
    show EventTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/location_template.dart'
    show LocationTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/phone_template.dart'
    show PhoneTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/sms_template.dart'
    show SmsTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/text_template.dart'
    show TextTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/website_template.dart'
    show WebsiteTemplate;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/wifi_template.dart'
    show WifiTemplate;

ToolConfig getPopularTool(PopularType val) => switch (val) {
  PopularType.text => ToolConfig(
    icon: AppIcons.textIcon,
    title: (l) => l.text,
    buildController: (l) =>
        TextController(title: l.text, iconSvgPath: AppIcons.textIcon),
    buildTemplate: (c) => TextTemplate(templateController: c as TextController),
  ),
  PopularType.event => ToolConfig(
    icon: AppIcons.eventIcon,
    title: (l) => l.event,
    buildController: (l) =>
        EventController(title: l.event, iconSvgPath: AppIcons.eventIcon),
    buildTemplate: (c) =>
        EventTemplate(templateController: c as EventController),
  ),
  PopularType.wifi => ToolConfig(
    icon: AppIcons.wifiIcon,
    title: (l) => l.wifi,
    buildController: (l) =>
        WifiController(title: l.wifi, iconSvgPath: AppIcons.wifiIcon),
    buildTemplate: (c) => WifiTemplate(templateController: c as WifiController),
  ),
  PopularType.email => ToolConfig(
    icon: AppIcons.emailIcon,
    title: (l) => l.email,
    buildController: (l) =>
        EmailController(title: l.email, iconSvgPath: AppIcons.emailIcon),
    buildTemplate: (c) =>
        EmailTemplate(templateController: c as EmailController),
  ),
  PopularType.sms => ToolConfig(
    icon: AppIcons.smsIcon,
    title: (l) => l.sms,
    buildController: (l) =>
        SmsController(title: l.sms, iconSvgPath: AppIcons.smsIcon),
    buildTemplate: (c) => SmsTemplate(templateController: c as SmsController),
  ),
  PopularType.phone => ToolConfig(
    icon: AppIcons.telephoneIcon,
    title: (l) => l.telephone,
    buildController: (l) => PhoneController(
      title: l.telephone,
      iconSvgPath: AppIcons.telephoneIcon,
    ),
    buildTemplate: (c) =>
        PhoneTemplate(templateController: c as PhoneController),
  ),
  PopularType.contact => ToolConfig(
    icon: AppIcons.contactIcon,
    title: (l) => l.contact,
    buildController: (l) =>
        ContactController(title: l.contact, iconSvgPath: AppIcons.contactIcon),
    buildTemplate: (c) =>
        ContactTemplate(templateController: c as ContactController),
  ),
  PopularType.location => ToolConfig(
    icon: AppIcons.locationIcon,
    title: (l) => l.location,
    buildController: (l) => LocationController(
      title: l.location,
      iconSvgPath: AppIcons.contactIcon,
    ),
    buildTemplate: (c) =>
        LocationTemplate(templateController: c as LocationController),
  ),
  PopularType.website => ToolConfig(
    icon: AppIcons.websiteIcon,
    title: (l) => l.website,
    buildController: (l) =>
        WebsiteController(title: l.website, iconSvgPath: AppIcons.websiteIcon),
    buildTemplate: (c) =>
        WebsiteTemplate(templateController: c as WebsiteController),
  ),
};
