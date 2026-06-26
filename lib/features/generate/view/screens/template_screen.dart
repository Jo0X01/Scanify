import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart';
import 'package:qrcode_scanner_app/features/generate/view/widgets/generate_screen_form_custom_widget.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({
    super.key,
    required this.templateController,
    required this.child,
  });

  final GenerateTemplateController templateController;
  final Widget child;

  static const String routeName = AppRoutes.templateScreen;

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _onSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final data = widget.templateController.buildQrData();
    final model = QRCodeModel.fromData(
      data,
      type: widget.templateController.dataType,
      format: widget.templateController.dataFormat,
      source: QrSourceType.generate,
    );
    if (!mounted) return;
    await AppRoutes.navigateTo(
      context,
      AppRoutes.detailsScreen,
      arguments: [model],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GenerateScreenFormCustomWidget(
        title: widget.templateController.title,
        icon: widget.templateController.iconSvgPath,
        onTap: _onSubmit,
        formChild: widget.child,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.templateController.init();
  }

  @override
  void dispose() {
    widget.templateController.dispose();
    super.dispose();
  }
}
