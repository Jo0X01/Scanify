import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';

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
        constraints: BoxConstraints(minWidth: 85, maxWidth: double.infinity),
        height: 85,
        width: context.mq.size.width / 10,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.onSurface),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset(
              icon,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                context.colorTheme.primary,
                BlendMode.srcIn,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
