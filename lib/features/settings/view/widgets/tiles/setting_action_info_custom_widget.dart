import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/settings/view/widgets/setting_tile_custom_widget.dart'
    show SettingTileCustomWidget;

class SettingActionInfoCustomWidget extends StatelessWidget {
  const SettingActionInfoCustomWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.onTap,
    this.enable,
    this.valueContent,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final String? valueContent;
  final IconData? icon;
  final bool? enable;
  final String? iconPath;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return SettingTileCustomWidget(
      enable: enable,
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconPath: iconPath,
      onTap: onTap,
      isDestructive: isDestructive,
      trailingWidget: valueContent != null
          ? Text(
              valueContent!,
              style: TextStyle(
                color: context.colorTheme.outlineVariant,
                fontSize: 12,
              ),
            )
          : Icon(
              Icons.chevron_right_rounded,
              color: context.colorTheme.primary,
              size: 20,
            ),
    );
  }
}
