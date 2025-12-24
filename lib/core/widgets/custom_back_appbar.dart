import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomBackAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      leading: null,
      // elevation: 10,
      automaticallyImplyLeading: false,
      title: Row(
        spacing: 25,
        children: [
          GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.tabBackgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: SvgPicture.asset(AppIcons.backIcon, width: 25, height: 25),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  
  @override
  Size get preferredSize => Size.fromHeight(80);
}
