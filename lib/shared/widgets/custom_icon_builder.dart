import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconBuilder extends StatelessWidget {
  const CustomIconBuilder({
    super.key,
    required this.color,
    required this.iconPath,
    required this.icon,
  });

  final Color color;
  final String? iconPath;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (iconPath != null) {
      return SvgPicture.asset(
        iconPath!,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        width: 18,
        height: 18,
      );
    }
    if (icon != null) {
      return Icon(icon, color: color, size: 18);
    }
    return const SizedBox.shrink();
  }
}
