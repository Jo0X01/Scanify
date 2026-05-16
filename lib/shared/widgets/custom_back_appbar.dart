import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomBackAppBar({
    super.key,
    required this.title,
    this.hasBack = true,
    this.addSettings = false,
  });
  final String title;
  final bool hasBack;
  final bool addSettings;
  final double _height = 80;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _height,
      leading: null,
      automaticallyImplyLeading: false,
      title: Row(
        spacing: 27,
        children: [
          if (hasBack)
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  // color: AppColors.tabBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SvgPicture.asset(
                  AppIcons.backIcon,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          Text(title),
          Spacer(),
          if (addSettings)
            GestureDetector(
              onTap: () =>
                  AppRoutes.navigateTo(context, AppRoutes.settingsScreen),
              child: SvgPicture.asset(
                AppIcons.settingsIcon,
                width: 30,
                height: 30,
              ),
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
