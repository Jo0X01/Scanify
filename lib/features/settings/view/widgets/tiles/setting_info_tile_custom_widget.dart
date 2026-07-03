import 'package:flutter/material.dart';
import 'package:scanify/features/settings/view/widgets/setting_tile_custom_widget.dart';

class SettingInfoTileCustomWidget extends StatelessWidget {
  const SettingInfoTileCustomWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.onTap,
    this.isDestructive = false,
    this.hiddenListener,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? iconPath;
  final VoidCallback? onTap;
  final bool isDestructive;

  final ValueNotifier<bool>? hiddenListener;

  @override
  Widget build(BuildContext context) {
    if (hiddenListener != null) {
      return ValueListenableBuilder(
        valueListenable: hiddenListener!,
        builder: (_, value, _) => SettingTileCustomWidget(
          title: title,
          onTap: onTap,
          isDestructive: isDestructive,
          hidden: value,
          icon: icon,
          iconPath: iconPath,
        ),
      );
    }
    return SettingTileCustomWidget(
      title: title,
      onTap: onTap,
      isDestructive: isDestructive,
      icon: icon,
      iconPath: iconPath,
    );
  }
}
