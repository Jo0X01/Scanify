import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';

class SettingSelectorTile<T extends Enum> extends StatelessWidget {
  const SettingSelectorTile({
    super.key,
    required this.title,
    required this.options,
    required this.listener,
    required this.onListen,
    this.defaultOption,
    this.defaultValue,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.onSelect,
    this.isDestructive = false,
  });

  final ValueNotifier<T> listener;
  final ValueChanged<T> onListen;
  final String title;
  final String? subtitle;
  final T? defaultOption;
  final String? defaultValue;
  final Map<T, String> options;
  final IconData? icon;
  final String? iconPath;
  final bool isDestructive;
  final void Function(T)? onSelect;

  String _getDefaultOption() {
    return options[listener.value] ??
        defaultValue ??
        options.entries.first.value;
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    final color = isDestructive ? themeColor.error : themeColor.primary;
    final iconWidget = _buildIcon(color);
    final leadingIconColor = isDestructive
        ? themeColor.error
        : themeColor.primary;
    final textColor = isDestructive ? themeColor.error : Colors.white;
    themeColor.secondaryContainer;

    return ValueListenableBuilder(
      valueListenable: listener,
      builder: (_, value, _) {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          minVerticalPadding: 5,
          onTap: () => _onTapLogic(context),
          leading: _buildLeading(iconWidget, leadingIconColor),
          title: _buildTitle(textColor),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: subtitle != null
                ? Text(
                    subtitle!,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                : null,
          ),
          trailing: Text(
            _getDefaultOption(),
            // style: TextStyle(color: themeColor.primary, fontSize: 13),
          ),
        );
      },
    );
  }

  Widget? _buildLeading(Widget? iconWidget, Color color) {
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

  Widget _buildTitle(Color textColor) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
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

  void _onTapLogic(BuildContext context) => AppDialogs.showPicker<String>(
    context: context,
    title: title,
    options: defaultValue == null
        ? options.values.toList()
        : [defaultValue!, ...options.values],
    current: _getDefaultOption(),
    onSelected: (current) {
      if (current == (defaultValue ?? options.entries.first.value)) {
        listener.value = defaultOption ?? options.entries.first.key;
      } else {
        listener.value = options.entries
            .firstWhere((elemnet) => elemnet.value == current)
            .key;
      }
      return onListen(listener.value);
    },
  );
}
