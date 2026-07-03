import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/contact_controller.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart';

class ContactTemplate extends StatefulWidget {
  const ContactTemplate({super.key, required this.templateController});
  final ContactController templateController;

  @override
  State<ContactTemplate> createState() => _ContactTemplateState();
}

class _ContactTemplateState extends State<ContactTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.nameController,
          validator: (val) => Validator.validateName(val)?.message(context.l),
          hintText: context.l.enterName,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.phoneController,
          validator: (val) =>
              Validator.validatePhoneNumber(val)?.message(context.l),
          hintText: context.l.enterPhone,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.emailController,
          validator: (val) => Validator.validateIgnoreEmpty(
            val,
            Validator.validateEmail,
            context.l,
          ),
          hintText: context.l.enterEmailOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.websiteController,
          validator: (val) => Validator.validateIgnoreEmpty(
            val,
            Validator.validateUrl,
            context.l,
          ),
          hintText: context.l.enterWebsiteOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.companyController,
          validator: (val) => Validator.validateIgnoreEmpty(
            val,
            Validator.validateName,
            context.l,
          ),
          hintText: context.l.enterCompanyOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.jobController,
          validator: (val) => Validator.validateIgnoreEmpty(
            val,
            Validator.validateName,
            context.l,
          ),
          hintText: context.l.enterJobOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.addressController,
          validator: (val) => Validator.validateIgnoreEmpty(
            val,
            Validator.validateContent,
            context.l,
          ),
          hintText: context.l.enterAddressOptional,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.noteController,
          isTextBox: true,
          validator: (val) => Validator.validateIgnoreEmpty(
            val,
            Validator.validateContent,
            context.l,
          ),
          hintText: context.l.enterNoteOptional,
        ),
      ],
    );
  }
}
