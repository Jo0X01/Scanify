import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/features/settings/view/widgets/setting_item_custom_widget.dart';

class SettingTileCustomWidget extends StatelessWidget {
  const SettingTileCustomWidget({super.key, required this.item});
  final SettingItem item;

  @override
  Widget build(BuildContext context) {
    final color = item.isDestructive ? AppColors.error : AppColors.iconColor;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: (item.isDestructive ? AppColors.error : AppColors.primary)
              .withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(item.icon, color: color, size: 18),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: item.isDestructive ? AppColors.error : AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      minVerticalPadding: 5,
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            )
          : null,
      trailing: _buildTrailing(),
      onTap: item.type == SettingType.toggle ? null : item.onTap,
    );
  }

  Widget? _buildTrailing() {
    switch (item.type) {
      case SettingType.toggle:
        return ValueListenableBuilder<bool>(
          valueListenable: item.toggleNotifier!,
          builder: (_, value, __) => Switch(
            value: value,
            activeThumbColor: AppColors.primary,
            onChanged: (v) {
              if (item.onToggleChanged != null) {
                item.onToggleChanged!(v);
              } else {
                item.toggleNotifier!.value = v;
              }
            },
          ),
        );

      case SettingType.selector:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.currentValue ?? '',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.iconColor,
              size: 20,
            ),
          ],
        );

      case SettingType.info:
        return Text(
          item.currentValue ?? '',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        );

      case SettingType.action:
        return item.isDestructive
            ? null
            : const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.iconColor,
                size: 20,
              );
    }
  }
}
