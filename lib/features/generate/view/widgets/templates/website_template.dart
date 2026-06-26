

import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/website_controller.dart' show WebsiteController;
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart' show TextFormFieldWithLabelCustomWidget;

class WebsiteTemplate extends StatefulWidget {
  const WebsiteTemplate({super.key,required this.templateController});
  final WebsiteController templateController;

  @override
  State<WebsiteTemplate> createState() => _WebsiteTemplateState();
}

class _WebsiteTemplateState extends State<WebsiteTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return TextFormFieldWithLabelCustomWidget(
      controller: widget.templateController.urlController,
      validator: (val) => Validator.validateUrl(val)?.message(l),
      hintText: l.enterWebsite,
    );
  }
}