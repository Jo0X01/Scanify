import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/features/generate/data/models/tool_data_model.dart';


class GenerateScreen extends StatefulWidget {
  GenerateScreen({super.key});
  static const String routeName = AppRoutes.generateScreen;

  final List<ToolDataModel> tools = [
    ToolDataModel(
      title: AppStrings.text,
      icon: AppIcons.textIcon,
      route: AppRoutes.textScreen,
    ),
    ToolDataModel(
      title: AppStrings.website,
      icon: AppIcons.websiteIcon,
      route: AppRoutes.websiteScreen,
    ),
    ToolDataModel(
      title: AppStrings.wifi,
      icon: AppIcons.wifiIcon,
      route: AppRoutes.wifiScreen,
    ),
    ToolDataModel(
      title: AppStrings.event,
      icon: AppIcons.eventIcon,
      route: AppRoutes.eventScreen,
    ),
    ToolDataModel(
      title: AppStrings.contact,
      icon: AppIcons.contactIcon,
      route: AppRoutes.contactScreen,
    ),
    ToolDataModel(
      title: AppStrings.business,
      icon: AppIcons.businessIcon,
      route: AppRoutes.businessScreen,
    ),
    ToolDataModel(
      title: AppStrings.location,
      icon: AppIcons.locationIcon,
      route: AppRoutes.locationScreen,
    ),
    ToolDataModel(
      title: AppStrings.whatsapp,
      icon: AppIcons.whatsappIcon,
      route: AppRoutes.whatsappScreen,
    ),
    ToolDataModel(
      title: AppStrings.email,
      icon: AppIcons.emailIcon,
      route: AppRoutes.emailScreen,
    ),
    ToolDataModel(
      title: AppStrings.twitter,
      icon: AppIcons.twitterIcon,
      route: AppRoutes.twitterScreen,
    ),
    ToolDataModel(
      title: AppStrings.instagram,
      icon: AppIcons.instagramIcon,
      route: AppRoutes.instagramScreen,
    ),
    ToolDataModel(
      title: AppStrings.telephone,
      icon: AppIcons.telephoneIcon,
      route: AppRoutes.telephoneScreen,
    ),
  ];

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.generate),
        actions: [
          SvgPicture.asset(AppIcons.settingsIcon, width: 30, height: 30),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(bottom: 120),
        child: SingleChildScrollView(
          child: Wrap(
            children: widget.tools.map((tool) => _clickableIcon(tool)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _clickableIcon(ToolDataModel tool) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, tool.route),
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width / 4 - 10,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 13),
        margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: AppColors.gray),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(tool.icon, width: 40, height: 40),
            Positioned(
              left: 0,
              right: 0,
              top: 50,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  tool.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
