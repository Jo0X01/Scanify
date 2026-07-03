import 'package:flutter/material.dart';
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/features/settings/view/widgets/setting_tile_custom_widget.dart';

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
    this.enable,
    this.enableListener,
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
  final bool? enable;
  final ValueNotifier<bool>? enableListener;

  @override
  Widget build(BuildContext context) {
    return SettingTileCustomWidget(
      enable: enable,
      enableListener: enableListener,
      title: title,
      icon: icon,
      iconPath: iconPath,
      isDestructive: isDestructive,
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
    );
  }
}
