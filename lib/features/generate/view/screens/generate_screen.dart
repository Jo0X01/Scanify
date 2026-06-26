import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/features/generate/view/config/barcode_tool_config.dart'
    show getBarcodeTool;
import 'package:qrcode_scanner_app/features/generate/view/config/popular_tool_config.dart'
    show getPopularTool;
import 'package:qrcode_scanner_app/features/generate/view/config/social_tool_config.dart'
    show getSocialTool;
import 'package:qrcode_scanner_app/features/generate/view/config/tool_config.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/generate_controller.dart'
    show GenerateScreenController;
import 'package:qrcode_scanner_app/features/generate/view/screens/template_screen.dart'
    show TemplateScreen;
import 'package:qrcode_scanner_app/features/generate/view/widgets/tool_icon_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});
  static const String routeName = AppRoutes.generateScreen;

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final _screenController = GenerateScreenController();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomBackAppBar(
        title: l.generateQRCode,
        hasBack: false,
        addSettings: true,
        kbHeight: MediaQuery.of(context).size.height / 12,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            _catBuilder(
              context,
              l,
              title: l.popularCategory,
              tools: _screenController.popularOnly
                  .map((e) => getPopularTool(e))
                  .toList(),
            ),
            _catBuilder(
              context,
              l,
              title: l.socialCategory,
              tools: _screenController.socialOnly
                  .map((e) => getSocialTool(e))
                  .toList(),
            ),
            _catBuilder(
              context,
              l,
              title: l.barcodeCategory,
              tools: _screenController.barcodeOnly
                  .map((e) => getBarcodeTool(e))
                  .toList(),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _catBuilder(
    BuildContext context,
    AppLocalizations l, {
    required List<ToolConfig> tools,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.topCenter,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: tools
                .map((e) => iconBuilder(context, l: l, tool: e))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget iconBuilder(
    BuildContext context, {
    required AppLocalizations l,
    required ToolConfig tool,
  }) {
    return ToolIconCustomWidget(
      title: tool.title(l),
      icon: tool.icon,
      onTap: () {
        final controller = tool.buildController(l);
        AppRoutes.navigate(
          context,
          TemplateScreen(
            templateController: controller,
            child: tool.buildTemplate(controller),
          ),
        );
      },
    );
  }
}
