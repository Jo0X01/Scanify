import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/social_controller.dart'
    show SocialController;
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart'
    show TextFormFieldWithLabelCustomWidget;

class SocialTemplate extends StatefulWidget {
  const SocialTemplate({super.key, required this.templateController});
  final SocialController templateController;

  @override
  State<SocialTemplate> createState() => _SocialTemplateState();
}

class _SocialTemplateState extends State<SocialTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
          widget.templateController.desc,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        if (widget.templateController.hasUsername)
          TextFormFieldWithLabelCustomWidget(
            controller: widget.templateController.usernameController,
            validator: widget.templateController.usernameValidator,
            hintText: context.l.enterUsernameId,
          ),
        if (widget.templateController.hasPhone)
          TextFormFieldWithLabelCustomWidget(
            controller: widget.templateController.phoneController,
            validator: (val) => Validator.validatePhoneNumber(val)?.message(context.l),
            hintText: context.l.enterPhone,
          ),
      ],
    );
  }
}
