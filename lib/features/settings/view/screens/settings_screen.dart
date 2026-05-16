import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/services/hive_service.dart';
import 'package:qrcode_scanner_app/core/services/settings_service.dart';
import 'package:qrcode_scanner_app/features/settings/view/widgets/section_custom_widget.dart';
import 'package:qrcode_scanner_app/features/settings/view/widgets/setting_item_custom_widget.dart';
import 'package:qrcode_scanner_app/features/settings/view/widgets/setting_tile_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const String routeName = AppRoutes.settingsScreen;

  SettingsService get _s => SettingsService.instance;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomBackAppBar(title: l.settings),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 32),
        children: [
          _appearanceSection(context, l),
          const SizedBox(height: 8),
          _scanningSection(l),
          const SizedBox(height: 8),
          _historySection(context, l),
          const SizedBox(height: 8),
          _aboutSection(l),
        ],
      ),
    );
  }

  Widget _appearanceSection(BuildContext context, AppLocalizations l) {
    return SectionCustomWidget(
      title: l.appearance,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: _s.language,
          builder: (_, lang, _) => SettingItemCustomWidget(
            item: SettingItem(
              title: l.language,
              icon: Icons.language_outlined,
              type: SettingType.selector,
              currentValue: SettingsService.languageLabels[lang] ?? 'English',
              onTap: () => AppDialogs.showPicker(
                context: context,
                title: l.language,
                options: SettingsService.languageLabels.values.toList(),
                current: SettingsService.languageLabels[lang] ?? 'English',
                onSelected: (label) {
                  final code = SettingsService.languageLabels.entries
                      .firstWhere((e) => e.value == label)
                      .key;
                  _s.setLanguage(code);
                },
              ),
            ),
          ),
        ),

        ValueListenableBuilder<String>(
          valueListenable: _s.theme,
          builder: (_, theme, _) => SettingTileCustomWidget(
            item: SettingItem(
              title: l.theme,
              subtitle: l.themeSubtitle,
              icon: Icons.palette_outlined,
              type: SettingType.selector,
              currentValue: _themeLabel(theme, l),
              onTap: () => AppDialogs.showPicker(
                context: context,
                title: l.theme,
                options: [l.themeLight, l.themeDark, l.themeSystem],
                current: _themeLabel(theme, l),
                onSelected: (label) => _s.setTheme(_themeKey(label, l)),
              ),
            ),
          ),
        ),

        SettingTileCustomWidget(
          item: SettingItem(
            title: l.amoled,
            subtitle: l.amoledSubtitle,
            icon: Icons.brightness_1_outlined,
            type: SettingType.toggle,
            toggleNotifier: _s.amoled,
            onToggleChanged: _s.setAmoled,
          ),
        ),
      ],
    );
  }

  Widget _scanningSection(AppLocalizations l) {
    return SectionCustomWidget(
      title: l.scanning,
      children: [
        SettingTileCustomWidget(
          item: SettingItem(
            title: l.autoScan,
            subtitle: l.autoScanSubtitle,
            icon: Icons.bolt_outlined,
            type: SettingType.toggle,
            toggleNotifier: _s.autoScan,
            onToggleChanged: _s.setAutoScan,
          ),
        ),
        SettingTileCustomWidget(
          item: SettingItem(
            title: l.sound,
            subtitle: l.soundSubtitle,
            icon: Icons.volume_up_outlined,
            type: SettingType.toggle,
            toggleNotifier: _s.sound,
            onToggleChanged: _s.setSound,
          ),
        ),
        SettingTileCustomWidget(
          item: SettingItem(
            title: l.haptics,
            subtitle: l.hapticsSubtitle,
            icon: Icons.vibration_outlined,
            type: SettingType.toggle,
            toggleNotifier: _s.haptics,
            onToggleChanged: _s.setHaptics,
          ),
        ),
      ],
    );
  }

  Widget _historySection(BuildContext context, AppLocalizations l) {
    return SectionCustomWidget(
      title: l.history,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: _s.autoDelete,
          builder: (_, autoDelete, __) => SettingTileCustomWidget(
            item: SettingItem(
              title: l.autoDelete,
              subtitle: l.autoDeleteSubtitle,
              icon: Icons.auto_delete_outlined,
              type: SettingType.selector,
              currentValue: _autoDeleteLabel(autoDelete, l),
              onTap: () => AppDialogs.showPicker(
                context: context,
                title: l.autoDelete,
                options: [
                  l.autoDeleteNever,
                  l.autoDelete7,
                  l.autoDelete30,
                  l.autoDelete90,
                ],
                current: _autoDeleteLabel(autoDelete, l),
                onSelected: (label) =>
                    _s.setAutoDelete(_autoDeleteKey(label, l)),
              ),
            ),
          ),
        ),

        SettingTileCustomWidget(
          item: SettingItem(
            title: l.clearHistory,
            icon: Icons.delete_sweep_outlined,
            type: SettingType.action,
            isDestructive: true,
            onTap: () => AppDialogs.showConfirm(
              context,
              title: l.clearHistoryTitle,
              content: l.clearHistoryMessage,
              cancelText: l.cancel,
              confirmText: l.clear,
              onConfirm: HiveService.clear,
            ),
          ),
        ),
      ],
    );
  }

  Widget _aboutSection(AppLocalizations l) {
    return SectionCustomWidget(
      title: l.about,
      children: [
        SettingTileCustomWidget(
          item: SettingItem(
            title: l.version,
            icon: Icons.info_outline_rounded,
            type: SettingType.info,
            currentValue: AppStrings.appVersion,
          ),
        ),
        SettingTileCustomWidget(
          item: SettingItem(
            title: l.sendFeedback,
            icon: Icons.feedback_outlined,
            type: SettingType.action,
            onTap: () {
              /* TODO */
            },
          ),
        ),
        SettingTileCustomWidget(
          item: SettingItem(
            title: l.privacyPolicy,
            icon: Icons.privacy_tip_outlined,
            type: SettingType.action,
            onTap: () {
              /* TODO */
            },
          ),
        ),
      ],
    );
  }

  String _themeLabel(String key, AppLocalizations l) => switch (key) {
    'light' => l.themeLight,
    'dark' => l.themeDark,
    _ => l.themeSystem,
  };

  String _themeKey(String label, AppLocalizations l) => switch (label) {
    _ when label == l.themeLight => 'light',
    _ when label == l.themeDark => 'dark',
    _ => 'system',
  };

  String _autoDeleteLabel(String key, AppLocalizations l) => switch (key) {
    '7days' => l.autoDelete7,
    '30days' => l.autoDelete30,
    '90days' => l.autoDelete90,
    _ => l.autoDeleteNever,
  };

  String _autoDeleteKey(String label, AppLocalizations l) => switch (label) {
    _ when label == l.autoDelete7 => '7days',
    _ when label == l.autoDelete30 => '30days',
    _ when label == l.autoDelete90 => '90days',
    _ => 'never',
  };
}
