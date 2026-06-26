import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class SettingActionInfoCustomWidget extends StatelessWidget {
  const SettingActionInfoCustomWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.onTap,
    this.valueContent,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final String? valueContent;
  final IconData? icon;
  final String? iconPath;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.iconColor;
    final iconWidget = _buildIcon(color);
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: Colors.transparent,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      minVerticalPadding: 5,
      leading: _buildLeading(iconWidget),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: _buildSubtitle(),
      trailing: valueContent != null
          ? Text(
              valueContent!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            )
          : const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.iconColor,
              size: 20,
            ),
    );
  }

  Widget? _buildLeading(Widget? iconWidget) {
    if (iconWidget == null) return null;
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: (isDestructive ? AppColors.error : AppColors.primary).withValues(
          alpha: 0.12,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: iconWidget,
    );
  }

  Widget? _buildSubtitle() {
    if (subtitle == null) return null;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        subtitle!,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
    );
  }

  Widget? _buildIcon(Color color) {
    if (iconPath != null) {
      return SvgPicture.asset(
        iconPath!,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        width: 18,
        height: 18,
      );
    }
    if (icon != null) return Icon(icon, color: color, size: 18);
    return null;
  }
}
