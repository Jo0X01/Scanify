import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/settings/view/widgets/setting_tile_custom_widget.dart';
import 'package:scanify/shared/widgets/switch_custom_widget.dart';

class SettingToggleTile extends StatelessWidget {
  const SettingToggleTile({
    super.key,
    required this.title,
    required this.listener,
    required this.onChanged,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.enable,
    this.isDestructive = false,
    this.enableListener,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? iconPath;
  final bool isDestructive;
  final bool? enable;
  final ValueNotifier<bool>? enableListener;
  final ValueNotifier<bool> listener;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SettingTileCustomWidget(
      title: title,
      subtitle: subtitle,
      enableListener: enableListener,
      icon: icon,
      iconPath: iconPath,
      enable: enable ?? true,
      isDestructive: isDestructive,
      onTap: () {
        if (enable ?? true) onChanged(!listener.value);
      },
      trailingWidget: ValueListenableBuilder(
        valueListenable: listener,
        builder: (_, value, _) {
          return SwitchCustomWidget(
            value: listener.value,
            activeColor: context.colorTheme.primary,
            inactiveColor: context.colorTheme.onSurface,
            size: 22,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}
