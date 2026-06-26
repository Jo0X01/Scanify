

import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/text_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart' show TextFormFieldWithLabelCustomWidget;

class TextTemplate extends StatefulWidget {
  const TextTemplate({super.key,required this.templateController});
  final TextController templateController;

  @override
  State<TextTemplate> createState() => _TextTemplateteState();
}

class _TextTemplateteState extends State<TextTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return TextFormFieldWithLabelCustomWidget(
      controller: widget.templateController.textController,
      validator: (val) => Validator.validateContent(val)?.message(l),
      hintText: l.enterText,
      isTextBox: true,
    );
  }
}