import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/email_controller.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart';

class EmailTemplate extends StatefulWidget {
  const EmailTemplate({super.key, required this.templateController});
  final EmailController templateController;

  @override
  State<EmailTemplate> createState() => _EmailTemplateeState();
}

class _EmailTemplateeState extends State<EmailTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.emailController,
          validator: (val) => Validator.validateEmail(val)?.message(context.l),
          hintText: context.l.enterEmail,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.subjectController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateContent,context.l),
          hintText: context.l.subjectEnterOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          isTextBox: true,
          controller: widget.templateController.bodyController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateContent,context.l),
          hintText: context.l.bodyEnterOptional,
        ),
      ],
    );
  }
}
