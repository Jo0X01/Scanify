import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart'
    show CustomBackAppBar;

class NoQrDataWidget extends StatelessWidget {
  const NoQrDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomBackAppBar(title: l.details),
      body: Center(
        child: Text(l.noDataProvided, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
