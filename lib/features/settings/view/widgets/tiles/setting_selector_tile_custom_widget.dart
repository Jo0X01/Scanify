import 'package:flutter/material.dart';
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/settings/view/widgets/setting_tile_custom_widget.dart'
    show SettingTileCustomWidget;

class SettingSelectorTile<T extends Enum> extends StatelessWidget {
  const SettingSelectorTile({
    super.key,
    required this.title,
    required this.options,
    required this.listener,
    required this.onListen,
    this.defaultEntry,
    this.subtitle,
    this.icon,
    this.iconPath,
    this.onSelect,
    this.enable,
    this.enableListener,
    this.isDestructive = false,
  });

  final ValueNotifier<T> listener;
  final ValueChanged<T> onListen;
  final String title;
  final String? subtitle;
  final MapEntry<T, String>? defaultEntry;
  final Map<T, String> options;
  final IconData? icon;
  final String? iconPath;
  final bool isDestructive;
  final bool? enable;
  final ValueNotifier<bool>? enableListener;
  final void Function(T)? onSelect;
  String _getCurrentLabel() {
    return options[listener.value] ??
        defaultEntry?.value ??
        options.entries.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return SettingTileCustomWidget(
      enableListener: enableListener,
      enable: enable,
      title: title,
      isDestructive: isDestructive,
      icon: icon,
      iconPath: iconPath,
      subtitle: subtitle,
      onTap: () => _onTapLogic(context),
      trailingWidget: _trailingWidget(context, enable ?? true),
      enableTrailingBuilder: (enableValue) =>
          _trailingWidget(context, enableValue),
    );
  }

  void _onTapLogic(BuildContext context) => AppDialogs.showPicker<String>(
    context: context,
    title: title,
    options: defaultEntry == null
        ? options.values.toList()
        : [defaultEntry!.value, ...options.values],
    current: _getCurrentLabel(),
    onSelected: (current) {
      if (defaultEntry != null && current == defaultEntry!.value) {
        listener.value = defaultEntry!.key;
      } else {
        listener.value = options.entries
            .firstWhere((e) => e.value == current)
            .key;
      }
      return onListen(listener.value);
    },
  );

  Widget _trailingWidget(BuildContext context, bool enableValue) {
    return ValueListenableBuilder(
      valueListenable: listener,
      builder: (_, value, _) => Wrap(
        spacing: 10,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: context.mq.size.width * 0.15),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _getCurrentLabel(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: enableValue
                      ? context.colorTheme.primary
                      : context.colorTheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
