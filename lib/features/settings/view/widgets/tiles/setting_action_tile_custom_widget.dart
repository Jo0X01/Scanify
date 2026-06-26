import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';

class SettingActionTileCustomWidget extends StatelessWidget {
  const SettingActionTileCustomWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.onTap,
    this.isDestructive = false,
    this.showDialog = true,
    this.onConfirmContent,
    this.onConfirmConfirmText,
    this.onConfirmCancelText,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? iconPath;
  final VoidCallback? onTap;
  final String? onConfirmContent;
  final String? onConfirmConfirmText;
  final String? onConfirmCancelText;
  final bool isDestructive;
  final bool showDialog;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.iconColor;
    final iconWidget = _buildIcon(color);
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: Colors.transparent,
      onTap: () {
        if (showDialog) {
          AppDialogs.showConfirm(
            context,
            title: title,
            content: onConfirmContent,
            cancelText: onConfirmCancelText,
            confirmText: onConfirmConfirmText,
            onConfirm: onTap,
          );
        } else {
          onTap?.call();
        }
      },
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
      trailing: isDestructive
          ? null
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
