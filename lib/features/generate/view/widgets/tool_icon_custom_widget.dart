import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ToolIconCustomWidget extends StatelessWidget {
  const ToolIconCustomWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 85,
          maxWidth: double.infinity
        ),
        width: MediaQuery.of(context).size.width / 10,
        height: 90,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.onPrimary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset(
              icon,
              width: 30,
              height: 30,
              colorFilter:  ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
