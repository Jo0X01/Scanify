import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanify/core/constants/app_assets.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';

class HistoryEmptyCustomWidget extends StatelessWidget {
  const HistoryEmptyCustomWidget({super.key, this.isSearch = false});

  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mq.size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            SvgPicture.asset(
              !isSearch ? AppIcons.emptyIcon : AppIcons.searchEmptyIcon,
              width: 120,
              height: 120,
              colorFilter: ColorFilter.mode(
                context.colorTheme.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 15),
            Text(
              !isSearch
                  ? context.l.emptyHistoryTitle
                  : context.l.emptySearchHistoryTitle,
              style: context.theme.textTheme.titleMedium,
            ),
            Text(
              !isSearch
                  ? context.l.emptyHistorySubtitle
                  : context.l.emptySearchHistorySubtitle,
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: context.colorTheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
