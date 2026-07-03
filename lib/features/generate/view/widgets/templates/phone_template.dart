

import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/phone_controller.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart' show TextFormFieldWithLabelCustomWidget;

class PhoneTemplate extends StatefulWidget {
  const PhoneTemplate({super.key,required this.templateController});
  final PhoneController templateController;

  @override
  State<PhoneTemplate> createState() => _PhoneTemplateState();
}

class _PhoneTemplateState extends State<PhoneTemplate> {
  @override
  Widget build(BuildContext context) {
    return TextFormFieldWithLabelCustomWidget(
      controller: widget.templateController.phoneController,
      validator: (val) => Validator.validatePhoneNumber(val)?.message(context.l),
      hintText: context.l.enterPhone,
    );
  }
}