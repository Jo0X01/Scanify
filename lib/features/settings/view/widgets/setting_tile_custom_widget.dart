import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';

class SettingTileCustomWidget extends StatelessWidget {
  const SettingTileCustomWidget({
    super.key,
    required this.title,
    this.trailingWidget,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.enable,
    this.isDestructive = false,
    this.onTap,
    this.hidden,
    this.enableListener,
    this.enableTrailingBuilder,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? iconPath;
  final Widget? trailingWidget;
  final bool isDestructive;
  final bool? enable;
  final ValueNotifier<bool>? enableListener;
  final bool? hidden;
  final void Function()? onTap;
  final Widget? Function(bool)? enableTrailingBuilder;

  @override
  Widget build(BuildContext context) {
    if (hidden ?? false) {
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder(
      valueListenable: enableListener ?? ValueNotifier(enable ?? true),
      builder: (_, enableValue, _) {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          minVerticalPadding: 4,
          enabled: enableValue,
          onTap: onTap,
          leading: _buildLeading(
            (enableValue
                ? isDestructive
                      ? context.colorTheme.error
                      : context.colorTheme.primary
                : context.colorTheme.outlineVariant),
            _buildIcon(
              (enableValue
                  ? isDestructive
                        ? context.colorTheme.error
                        : context.colorTheme.primary
                  : context.colorTheme.onSurface),
            ),
          ),
          title: _buildTitle(
            (enableValue
                ? isDestructive
                      ? context.colorTheme.error
                      : context.colorTheme.outlineVariant
                : context.colorTheme.onSurface),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle!,
                  style: TextStyle(
                    color: isDestructive
                        ? context.colorTheme.error
                        : context.colorTheme.onSurface,
                    fontSize: 12,
                  ),
                ),
          trailing: (enableListener != null && enableTrailingBuilder != null)
              ? enableTrailingBuilder?.call(enableValue)
              : trailingWidget,
        );
      },
    );
  }

  Widget? _buildLeading(Color color, Widget? iconWidget) {
    if (iconWidget == null) return null;
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: iconWidget,
    );
  }

  Widget? _buildTitle(Color color) {
    return Text(
      title,
      style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
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
