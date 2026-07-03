import 'package:flutter/material.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/generate/view/config/barcode_tool_config.dart'
    show getBarcodeTool;
import 'package:scanify/features/generate/view/config/popular_tool_config.dart'
    show getPopularTool;
import 'package:scanify/features/generate/view/config/social_tool_config.dart'
    show getSocialTool;
import 'package:scanify/features/generate/view/config/tool_config.dart';
import 'package:scanify/features/generate/view/controller/generate_controller.dart'
    show GenerateScreenController;
import 'package:scanify/features/generate/view/screens/template_screen.dart'
    show TemplateScreen;
import 'package:scanify/features/generate/view/widgets/tool_icon_custom_widget.dart';
import 'package:scanify/shared/widgets/custom_back_appbar.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});
  static const routeName = AppRouteKeys.generateScreen;

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final _screenController = GenerateScreenController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBackAppBar(
          title: context.l.generateQRCode,
          hasBack: false,
          addSettings: true,
          kbHeight: MediaQuery.of(context).size.height / 14,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: context.mq.size.height * 0.15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                _catBuilder(
                  context,
                  title: context.l.popularCategory,
                  tools: _screenController.popularOnly
                      .map((e) => getPopularTool(e))
                      .toList(),
                ),
                _catBuilder(
                  context,
                  title: context.l.socialCategory,
                  tools: _screenController.socialOnly
                      .map((e) => getSocialTool(e))
                      .toList(),
                ),
                _catBuilder(
                  context,
                  title: context.l.barcodeCategory,
                  tools: _screenController.barcodeOnly
                      .map((e) => getBarcodeTool(e))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _catBuilder(
    BuildContext context,{
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
          margin: const EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.topCenter,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: tools
                .map((e) => iconBuilder(context, tool: e))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget iconBuilder(
    BuildContext context, {
    required ToolConfig tool,
  }) {
    return ToolIconCustomWidget(
      title: tool.title(context.l),
      icon: tool.icon,
      onTap: () {
        final controller = tool.buildController(context.l);
        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          enableDrag: false,
          isScrollControlled: true,
          isDismissible: false,
          backgroundColor: Colors.transparent,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: GestureDetector(
                onTap: FocusManager.instance.primaryFocus?.unfocus,
                behavior: HitTestBehavior.opaque,
                child: TemplateScreen(
                  templateController: controller,
                  child: tool.buildTemplate(controller),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
