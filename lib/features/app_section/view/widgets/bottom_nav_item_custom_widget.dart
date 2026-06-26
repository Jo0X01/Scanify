import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BottomNavItemCustomWidget extends StatelessWidget {
  const BottomNavItemCustomWidget({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.navBarHeight,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double navBarHeight;

  @override
  Widget build(BuildContext context) {
    final iconSize = (navBarHeight * 0.38).clamp(22.0, 32.0);
    final fontSize = (navBarHeight * 0.15).clamp(10.0, 13.0);
    final theme = Theme.of(context);
  
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        height: navBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: SvgPicture.asset(
                iconPath,
                key: ValueKey('$isSelected-$label'),
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(
                  isSelected ? theme.primaryColor : theme.colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: navBarHeight * 0.04),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? theme.primaryColor : theme.colorScheme.secondary,
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              child: Text(label, textAlign: TextAlign.center),
            ),
            SizedBox(height: navBarHeight * 0.05),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? iconSize - 2 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
