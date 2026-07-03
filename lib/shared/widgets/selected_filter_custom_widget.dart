import 'package:flutter/material.dart'
    show AlertDialog, MaterialButton, Theme, showDialog;
import 'package:flutter/widgets.dart';
import 'package:scanify/shared/widgets/meta_text_custom_widget.dart'
    show MetaTextCustomWidget, MetaTextMode;

class SelectedFilterCustomWidget<T extends Enum> extends StatelessWidget {
  SelectedFilterCustomWidget({
    super.key,
    required this.title,
    required this.groupItems,
    required this.onChanged,
    this.applyText = "Apply",
    this.onApply,
    this.selectedIndexes,
  }) : _selectedItems =
           selectedIndexes?.entries.expand((item) => item.value).toSet() ??
           <T>{};

  final String title;
  final Map<String, Map<T, String>> groupItems;
  final void Function(String, T, bool)? onChanged;
  final void Function(Map<String, Map<T, String>>, Set<T>)? onApply;
  final String applyText;
  final Map<String, Set<T>>? selectedIndexes;

  final Set<T> _selectedItems;

  static void showSelectedDialog<S extends Enum>(
    BuildContext context, {
    required String title,
    required Map<String, Map<S, String>> groupItems,
    void Function(String, S, bool)? onChanged,
    void Function(Map<String, Map<S, String>>, Set<S>)? onApply,
    required String applyText,
    Map<String, Set<S>>? selectedIndexes,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        alignment: Alignment.topCenter,
        content: SelectedFilterCustomWidget<S>(
          title: title,
          applyText: applyText,
          selectedIndexes: selectedIndexes,
          groupItems: groupItems,
          onChanged: onChanged,
          onApply: onApply,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              for (final groupItem in groupItems.entries)
                _groupWidget(groupItem.key, groupItem.value),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.surface,
            onPressed: () {
              Navigator.pop(context);
              onApply?.call(groupItems, _selectedItems);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(applyText),
          ),
        ),
      ],
    );
  }

  bool _isSelectedItem(String key, String groupTitle, T value) {
    return selectedIndexes?[key]?.contains(value) ?? false;
  }

  Widget _groupWidget(String key, Map<T, String> groupItem) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(key),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final entry in groupItem.entries)
                _entryWidget(key, entry.value, entry.key),
            ],
          ),
        ),
      ],
    );
  }

  Widget _entryWidget(String key, String itemTitle, T value) {
    return MetaTextCustomWidget(
      label: itemTitle,
      mode: MetaTextMode.filter,
      fontSize: 12,
      radius: 20,
      initialToggle: _isSelectedItem(key, itemTitle, value),
      onToggle: (v) {
        if (v) {
          _selectedItems.add(value);
        } else {
          _selectedItems.remove(value);
        }
        onChanged?.call(itemTitle, value, v);
      },
    );
  }
}
