import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/social_controller.dart'
    show SocialController;
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart'
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
    final l = AppLocalizations.of(context)!;
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
            hintText: l.enterUsernameId,
          ),
        if (widget.templateController.hasPhone)
          TextFormFieldWithLabelCustomWidget(
            controller: widget.templateController.phoneController,
            validator: (val) => Validator.validatePhoneNumber(val)?.message(l),
            hintText: l.enterPhone,
          ),
      ],
    );
  }
}
