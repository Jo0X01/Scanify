import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/widgets/custom_back_appbar.dart';

class GenerateScreenFormCustomWidget extends StatelessWidget {
  const GenerateScreenFormCustomWidget({
    required this.onTap,
    required this.icon,
    required this.formChild,
    super.key,
  });
  final void Function() onTap;
  final String icon;
  final Widget formChild;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomBackAppBar(
          title: AppStrings.wifi,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 46, vertical: 25),
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.tabBackgroundColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.secondary, width: 2),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 45,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 60,
                  height: 60,
                  colorFilter: ColorFilter.mode(
                    AppColors.secondary,
                    BlendMode.srcIn,
                  ),
                ),
                formChild,
                MaterialButton(
                  onPressed: onTap,
                  color: AppColors.secondary,
                  textColor: AppColors.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(AppStrings.generateQRCode),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
