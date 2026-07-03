

import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/website_controller.dart' show WebsiteController;
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart' show TextFormFieldWithLabelCustomWidget;

class WebsiteTemplate extends StatefulWidget {
  const WebsiteTemplate({super.key,required this.templateController});
  final WebsiteController templateController;

  @override
  State<WebsiteTemplate> createState() => _WebsiteTemplateState();
}

class _WebsiteTemplateState extends State<WebsiteTemplate> {
  @override
  Widget build(BuildContext context) {
    return TextFormFieldWithLabelCustomWidget(
      controller: widget.templateController.urlController,
      validator: (val) => Validator.validateUrl(val)?.message(context.l),
      hintText: context.l.enterWebsite,
    );
  }
}