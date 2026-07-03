import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/sms_controller.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart'
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
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.phoneController,
          validator: (val) =>
              Validator.validatePhoneNumber(val)?.message(context.l),
          hintText: context.l.enterPhone,
        ),
        TextFormFieldWithLabelCustomWidget(
          isTextBox: true,
          controller: widget.templateController.messageController,
          validator: (value) => Validator.validateIgnoreEmpty(
            value,
            Validator.validateContent,
            context.l,
          ),
          hintText: context.l.enterMessageBodyOptional,
        ),
      ],
    );
  }
}
