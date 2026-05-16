import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class ActionButtonCustomWidget extends StatelessWidget {
  const ActionButtonCustomWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.size,
    required this.padding,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(size * 0.22),
              border: Border.all(color: AppColors.divider),
            ),
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(height: size * 0.1),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
