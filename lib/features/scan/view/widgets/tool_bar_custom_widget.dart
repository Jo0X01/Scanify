import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ToolBarData {
  final String icon;
  final Function(bool)? onTap;
  final ValueNotifier<bool>? isSelectedListener;
  final bool? isSelected;
  final bool callDefaultOnTap;

  ToolBarData({
    required this.icon,
    this.onTap,
    this.callDefaultOnTap = true,
    this.isSelectedListener,
    this.isSelected,
  });
}

class ToolBarCustomWidget extends StatefulWidget {
  const ToolBarCustomWidget({required this.tools, super.key});
  final List<ToolBarData> tools;

  @override
  State<ToolBarCustomWidget> createState() => _ToolBarCustomWidgetState();
}

class _ToolBarCustomWidgetState extends State<ToolBarCustomWidget> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      width: w * 0.80,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.tools
            .map(
              (tool) => ValueListenableBuilder(
                valueListenable:
                    tool.isSelectedListener ??
                    ValueNotifier(tool.isSelected ?? false),
                builder: (_, isSelectedValue, _) {
                  return GestureDetector(
                    onTap: () {
                      tool.onTap?.call(isSelectedValue);
                    },
                    child: SvgPicture.asset(
                      tool.icon,
                      width: 25,
                      height: 25,
                      colorFilter: ColorFilter.mode(
                        isSelectedValue
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
