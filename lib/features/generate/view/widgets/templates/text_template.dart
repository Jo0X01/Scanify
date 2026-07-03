

import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/text_controller.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart' show TextFormFieldWithLabelCustomWidget;

class TextTemplate extends StatefulWidget {
  const TextTemplate({super.key,required this.templateController});
  final TextController templateController;

  @override
  State<TextTemplate> createState() => _TextTemplateteState();
}

class _TextTemplateteState extends State<TextTemplate> {
  @override
  Widget build(BuildContext context) {
    return TextFormFieldWithLabelCustomWidget(
      controller: widget.templateController.textController,
      validator: (val) => Validator.validateContent(val)?.message(context.l),
      hintText: context.l.enterText,
      isTextBox: true,
    );
  }
}