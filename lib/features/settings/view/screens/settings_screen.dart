import 'package:flutter/material.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/enum/app_theme_mode.dart' show AppThemeMode;
import 'package:scanify/core/enum/auto_clear_detection_delay.dart';
import 'package:scanify/core/enum/auto_delete_history.dart';
import 'package:scanify/core/constants/app_strings.dart';
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/core/enum/av_language.dart';
import 'package:scanify/core/enum/qr_error_correction.dart';
import 'package:scanify/core/l10n/app_localizations.dart';
import 'package:scanify/features/settings/view/controller/settings_controller.dart';
import 'package:scanify/features/settings/view/widgets/setting_group_custom_widget.dart';
import 'package:scanify/features/settings/view/widgets/tiles/setting_action_info_custom_widget.dart';
import 'package:scanify/features/settings/view/widgets/tiles/setting_action_tile_custom_widget.dart';
import 'package:scanify/features/settings/view/widgets/tiles/setting_selector_tile_custom_widget.dart';
import 'package:scanify/features/settings/view/widgets/tiles/setting_toggle_tile_custom_widget.dart';
import 'package:scanify/features/settings/view/widgets/tiles/setting_info_tile_custom_widget.dart';
import 'package:scanify/shared/widgets/custom_back_appbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const AppRouteKeys routeName = AppRouteKeys.settingsScreen;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  late final SettingsController _screenController;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomBackAppBar(title: l.settings),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 32),
        children: [
          _warningSection(context, l),
          const SizedBox(height: 2),
          _appearanceSection(context, l),
          const SizedBox(height: 2),
          _scanningSection(l),
          const SizedBox(height: 2),
          _historySection(context, l),
          const SizedBox(height: 2),
          _aboutSection(context, l),
        ],
      ),
    );
  }

  Widget _warningSection(BuildContext context, AppLocalizations l) {
    return SettingInfoTileCustomWidget(
      hiddenListener: _screenController.permWarnListener,
      title: l.requireMissedPermissions,
      isDestructive: true,
      icon: Icons.warning_amber_rounded,
      onTap: _screenController.openSystemAppSettings,
    );
  }

  Widget _appearanceSection(BuildContext context, AppLocalizations l) {
    return SettingGroupCustomWidget(
      title: l.appearance,
      children: [
        SettingSelectorTile(
          listener: _screenController.settings.languageListener,
          title: l.language,
          subtitle: l.languageSubtitle,
          icon: Icons.language_outlined,
          options: AvLanguages.asMapLabel(l),
          onListen: _screenController.settings.setLanguage,
        ),
        SettingSelectorTile(
          listener: _screenController.settings.themeListener,
          title: l.theme,
          subtitle: l.themeSubtitle,
          icon: Icons.palette_outlined,
          options: AppThemeMode.asMapLabel(l),
          onListen: _screenController.settings.setTheme,
        ),
        SettingSelectorTile(
          listener: _screenController.settings.errorCorrectionListener,
          title: l.qrErrorCorrectionLvL,
          subtitle: l.qrErrorCorrectionLvLSubtitle,
          icon: Icons.mail_lock_outlined,
          options: QrErrorCorrectionLevel.asMapLabel(l),
          onListen: _screenController.settings.setErrorCorrectionLvL,
        ),

        SettingToggleTile(
          listener: _screenController.settings.showFullDetailsListener,
          title: l.showFullResultScan,
          subtitle: l.showFullResultScanSubTitle,
          icon: Icons.text_fields_sharp,
          onChanged: _screenController.settings.setShowFullDetails,
        ),
      ],
    );
  }

  Widget _scanningSection(AppLocalizations l) {
    return SettingGroupCustomWidget(
      title: l.scanning,
      children: [
        SettingSelectorTile(
          icon: Icons.av_timer_outlined,
          title: l.detectionClearTimeout,
          subtitle: l.detectionClearTimeoutContent,
          options: AutoClearDetectionDelay.asMapLabel(l),
          listener: _screenController.settings.autoClearDetectionListener,
          onListen: _screenController.settings.setAutoClearDetection,
        ),
        SettingToggleTile(
          listener: _screenController.settings.autoScanListener,
          title: l.autoScan,
          subtitle: l.autoScanSubtitle,
          icon: Icons.bolt_outlined,
          onChanged: _screenController.settings.setAutoScan,
        ),
        SettingToggleTile(
          listener: _screenController.settings.qrCodeOnlyListener,
          title: l.scanQrCodeOnly,
          subtitle: l.scanQrCodeOnlyContent,
          icon: Icons.qr_code_scanner_rounded,
          onChanged: _screenController.settings.setScanQrCodeOnly,
        ),
        SettingToggleTile(
          listener: _screenController.settings.soundListener,
          title: l.sound,
          subtitle: l.soundSubtitle,
          icon: Icons.volume_up_outlined,
          onChanged: _screenController.settings.setSound,
        ),
        SettingToggleTile(
          listener: _screenController.settings.hapticsListener,
          title: l.haptics,
          subtitle: l.hapticsSubtitle,
          icon: Icons.vibration_outlined,
          onChanged: _screenController.settings.setHaptics,
        ),
      ],
    );
  }

  Widget _historySection(BuildContext context, AppLocalizations l) {
    return SettingGroupCustomWidget(
      title: l.history,
      children: [
        SettingToggleTile(
          listener: _screenController.settings.enableHistoryListener,
          title: l.enableHistory,
          subtitle: l.enableHistoryDesc,
          icon: Icons.history,
          onChanged: _screenController.settings.setEnableHistory,
        ),
        SettingSelectorTile(
          listener: _screenController.settings.autoDeleteListener,
          enableListener: _screenController.settings.enableHistoryListener,
          title: l.autoDelete,
          subtitle: l.autoDeleteSubtitle,
          icon: Icons.auto_delete_outlined,
          options: AutoDeleteDay.asMapLabel(l),
          onListen: _screenController.settings.setAutoDeleteDay,
        ),
        SettingActionTileCustomWidget(
          title: l.clearHistory,
          icon: Icons.delete_sweep_outlined,
          isDestructive: true,
          enableListener: _screenController.settings.enableHistoryListener,
          onTap: _screenController.clearHistory,
          onConfirmContent: l.clearHistoryMessage,
          onConfirmConfirmText: l.clear,
          onConfirmCancelText: l.cancel,
        ),
      ],
    );
  }

  Widget _aboutSection(BuildContext context, AppLocalizations l) {
    return SettingGroupCustomWidget(
      title: l.about,
      children: [
        SettingActionInfoCustomWidget(
          title: l.version,
          icon: Icons.info_outline_rounded,
          valueContent: AppStrings.appVersion,
        ),
        SettingActionInfoCustomWidget(
          title: l.about,
          icon: Icons.feedback_outlined,
          onTap: () => AppDialogs.showAbout(
            context,
            title: l.about,
            content: l.aboutContent,
            versionText: l.version,
            closeText: l.agree,
          ),
        ),
        SettingActionInfoCustomWidget(
          title: l.privacyPolicy,
          icon: Icons.privacy_tip_outlined,
          onTap: () => AppDialogs.showSomeInfoDialog(
            context,
            title: l.privacyPolicy,
            content: l.privacyPolicyContent,
            closeText: l.agree,
          ),
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _screenController.checkPermissions();
    }
  }

  @override
  void initState() {
    super.initState();
    _screenController = SettingsController();
    _screenController.checkPermissions();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
