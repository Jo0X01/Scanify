import 'package:flutter/widgets.dart' show Widget;
import 'package:scanify/core/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart'
    show GenerateTemplateController;

class ToolConfig {
  final String icon;
  final String Function(AppLocalizations) title;
  final GenerateTemplateController Function(AppLocalizations) buildController;
  final Widget Function(GenerateTemplateController) buildTemplate;

  const ToolConfig({
    required this.icon,
    required this.title,
    required this.buildController,
    required this.buildTemplate,
  });
}
