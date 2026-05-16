import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/features/settings/view/widgets/setting_tile_custom_widget.dart';

enum SettingType { toggle, selector, action, info }

class SettingItem {
  const SettingItem({
    required this.title,
    required this.icon,
    required this.type,
    this.subtitle,
    this.toggleNotifier,
    this.onToggleChanged,
    this.currentValue,
    this.onTap,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final SettingType type;
  final ValueNotifier<bool>? toggleNotifier;
  final ValueChanged<bool>? onToggleChanged;
  final String? currentValue;
  final VoidCallback? onTap;
  final bool isDestructive;
}

class SettingItemCustomWidget extends StatelessWidget {
  const SettingItemCustomWidget({super.key, required this.item});

  final SettingItem item;

  @override
  Widget build(BuildContext context) {
    return SettingTileCustomWidget(item: item);
  }

}
