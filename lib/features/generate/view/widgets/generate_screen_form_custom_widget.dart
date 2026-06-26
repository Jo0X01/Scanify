import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart';

class GenerateScreenFormCustomWidget extends StatefulWidget {
  const GenerateScreenFormCustomWidget({
    required this.onTap,
    required this.icon,
    required this.formChild,
    super.key,
    required this.title,
  });
  final void Function() onTap;
  final String title;
  final String icon;
  final Widget formChild;

  @override
  State<GenerateScreenFormCustomWidget> createState() =>
      _GenerateScreenFormCustomWidgetState();
}

class _GenerateScreenFormCustomWidgetState
    extends State<GenerateScreenFormCustomWidget> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return PopScope(
      canPop: true,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        persistentFooterAlignment: AlignmentDirectional.center,
        appBar: CustomBackAppBar(title: l.generateQRCode, addSettings: false),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.tabBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.primary, width: 2),
                vertical: BorderSide(color: AppColors.primary, width: 0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                SvgPicture.asset(
                  widget.icon,
                  width: 40,
                  height: 40,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Divider(color: AppColors.lIconColor),
                widget.formChild,
                const Divider(color: AppColors.lIconColor),
                MaterialButton(
                  onPressed: widget.onTap,
                  color: AppColors.primary,
                  textColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(l.generate),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
