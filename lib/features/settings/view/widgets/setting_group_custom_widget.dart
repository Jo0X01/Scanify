import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';

class SettingGroupCustomWidget extends StatelessWidget {
  const SettingGroupCustomWidget({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 6),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: context.colorTheme.primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.transparent),
          ),
          child: Column(children: _buildChilderns(context.colorTheme.outline)),
        ),
      ],
    );
  }

  List<Widget> _buildChilderns(Color color) {
    List<Widget> widgets = [];
    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      if (i < children.length - 1) {
        widgets.add(Divider(height: 1, thickness: 2, color: color));
      }
    }
    return widgets;
  }
}
