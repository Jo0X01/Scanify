

import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/phone_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart' show TextFormFieldWithLabelCustomWidget;

class PhoneTemplate extends StatefulWidget {
  const PhoneTemplate({super.key,required this.templateController});
  final PhoneController templateController;

  @override
  State<PhoneTemplate> createState() => _PhoneTemplateState();
}

class _PhoneTemplateState extends State<PhoneTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return TextFormFieldWithLabelCustomWidget(
      controller: widget.templateController.phoneController,
      validator: (val) => Validator.validatePhoneNumber(val)?.message(l),
      hintText: l.enterPhone,
    );
  }
}