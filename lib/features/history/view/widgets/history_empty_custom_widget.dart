import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';

class HistoryEmptyCustomWidget extends StatelessWidget {
  const HistoryEmptyCustomWidget({super.key, this.isSearch = false});

  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final mq = MediaQuery.of(context).size.height * 0.6;
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: mq,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            SvgPicture.asset(
              !isSearch ? AppIcons.emptyIcon: AppIcons.searchEmptyIcon,
              width: 120,
              height: 120,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn
              ),
            ),
            SizedBox(height: 15,),
            Text(
              !isSearch ? l.emptyHistoryTitle:l.emptySearchHistoryTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              !isSearch ? l.emptyHistorySubtitle:l.emptySearchHistorySubtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}