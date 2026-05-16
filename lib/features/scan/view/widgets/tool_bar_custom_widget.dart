import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class ToolBarData {
  final String icon;
  final Function()? onTap;
  bool isSelected = false;
  final bool callDefaultOnTap;
  ToolBarData({required this.icon, this.onTap, this.callDefaultOnTap = true});
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
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 45, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.tabBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.tools
              .map((tool) => _toolIcon(index: widget.tools.indexOf(tool)))
              .toList(),
        ),
      ),
    );
  }

  Widget _toolIcon({required int index}) {
    final tool = widget.tools[index];

    return GestureDetector(
      onTap: () {
        if (tool.onTap != null) {
          tool.onTap!();
        }
        _defaultOnTap(index);
      },
      child: SvgPicture.asset(
        tool.icon,
        width: 25,
        height: 25,
        colorFilter: ColorFilter.mode(
          tool.isSelected ? Colors.orange : AppColors.iconColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  void _defaultOnTap(int index) {
    setState(() {
      if (widget.tools[index].callDefaultOnTap) {
        widget.tools[index].isSelected = !widget.tools[index].isSelected;
      }
    });
  }
}
