import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/contact_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';

class ContactTemplate extends StatefulWidget {
  const ContactTemplate({super.key, required this.templateController});
  final ContactController templateController;

  @override
  State<ContactTemplate> createState() => _ContactTemplateState();
}

class _ContactTemplateState extends State<ContactTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.nameController,
          validator: (val) => Validator.validateName(val)?.message(l),
          hintText: l.enterName,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.phoneController,
          validator: (val) => Validator.validatePhoneNumber(val)?.message(l),
          hintText: l.enterPhone,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.emailController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateEmail, l),
          hintText: l.enterEmailOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.websiteController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateUrl, l),
          hintText: l.enterWebsiteOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.companyController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateName, l),
          hintText: l.enterCompanyOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.jobController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateName, l),
          hintText: l.enterJobOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.addressController,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateContent, l),
          hintText: l.enterAddressOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.noteController,
          isTextBox: true,
          validator: (val) =>
              Validator.validateIgnoreEmpty(val, Validator.validateContent, l),
          hintText: l.enterNoteOptional,
        ),
      ],
    );
  }
}
