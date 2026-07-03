import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/shared/widgets/custom_back_appbar.dart'
    show CustomBackAppBar;

class NoQrDataWidget extends StatelessWidget {
  const NoQrDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(title: context.l.details),
      body: Center(
        child: Text(context.l.noDataProvided, style: context.theme.textTheme.bodyMedium),
      ),
    );
  }
}
