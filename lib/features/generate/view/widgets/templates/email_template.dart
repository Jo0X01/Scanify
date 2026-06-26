import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/email_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';

class EmailTemplate extends StatefulWidget {
  const EmailTemplate({super.key, required this.templateController});
  final EmailController templateController;

  @override
  State<EmailTemplate> createState() => _EmailTemplateeState();
}

class _EmailTemplateeState extends State<EmailTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.emailController,
          validator: (val) => Validator.validateEmail(val)?.message(l),
          hintText: l.enterEmail,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.subjectController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateContent,l),
          hintText: l.subjectEnterOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          isTextBox: true,
          controller: widget.templateController.bodyController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateContent,l),
          hintText: l.bodyEnterOptional,
        ),
      ],
    );
  }
}
