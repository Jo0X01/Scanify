import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/sms_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart'
    show TextFormFieldWithLabelCustomWidget;

class SmsTemplate extends StatefulWidget {
  const SmsTemplate({super.key, required this.templateController});
  final SmsController templateController;

  @override
  State<SmsTemplate> createState() => _SmsTemplateState();
}

class _SmsTemplateState extends State<SmsTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.phoneController,
          validator: (val) => Validator.validatePhoneNumber(val)?.message(l),
          hintText: l.enterPhone,
        ),
        TextFormFieldWithLabelCustomWidget(
          isTextBox: true,
          controller: widget.templateController.messageController,
          validator: (value) => Validator.validateIgnoreEmpty(
            value,
            Validator.validateContent,
            l
          ),
          hintText: l.enterMessageBodyOptional,
        ),
      ],
    );
  }

}
