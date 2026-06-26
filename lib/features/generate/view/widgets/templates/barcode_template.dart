import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/barcode_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';

class BarcodeTemplate extends StatefulWidget {
  const BarcodeTemplate({super.key, required this.templateController});
  final BarcodeController templateController;

  @override
  State<BarcodeTemplate> createState() => _BarcodeTemplateState();
}

class _BarcodeTemplateState extends State<BarcodeTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.inputController,
          validator: widget.templateController.validator,
          hintText: widget.templateController.desc,
          isTextBox: true,
          // labelText: widget.templateController.,
        )
      ],
    );
  }
}
