import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/shared/widgets/switch_custom_widget.dart';

class SettingToggleTile extends StatelessWidget {
  const SettingToggleTile({
    super.key,
    required this.title,
    required this.listener,
    required this.onChanged,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? iconPath;
  final bool isDestructive;
  final ValueNotifier<bool> listener;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.iconColor;
    final iconWidget = _buildIcon(color);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      minVerticalPadding: 5,
      onTap: () => listener.value = !listener.value,
      leading: _buildLeading(iconWidget),
      title: _buildTitle(),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: _buildsubTitle(),
      ),
      trailing: ValueListenableBuilder<bool>(
        valueListenable: listener,
        builder: (_, value, _) => SwitchCustomWidget(
          value: value,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.lIconColor,
          size: 22,
          onChanged: onChanged,
        ),
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

  Widget? _buildTitle() {
    return Text(
      title,
      style: TextStyle(
        color: isDestructive ? AppColors.error : AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget? _buildsubTitle() {
    if (subtitle == null) return null;
    return Text(
      subtitle!,
      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
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
