import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanify/core/constants/app_assets.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/features/scan/view/controller/scan_controller.dart';
import 'package:scanify/features/scan/view/widgets/center_qr_detector_widget.dart';
import 'package:scanify/features/scan/view/widgets/tool_bar_custom_widget.dart';
import 'package:scanify/shared/widgets/block_permission_custom_widget.dart'
    show BlockPermissionCustomWidget;
import 'package:scanify/shared/widgets/loading_screen.dart' show LoadingScreen;

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  static const routeName = AppRouteKeys.scanScreen;

  @override
  State<ScanScreen> createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  late final ScanController screenController;
  bool _suppressNextPopNext = false;

  void goToDetails() {
    final models = screenController.models;
    if (mounted && models.isNotEmpty) {
      context.goToDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screenController.screenState,
      builder: (_, value, _) => switch (value) {
        ScanState.loading => LoadingScreen(),
        ScanState.permission => BlockPermissionCustomWidget(
          icon: Icons.new_releases_rounded,
          title: context.l.permissionRequired,
          buttonTitle: context.l.openSettings,
          subtitle:
              "${context.l.requireMissedPermissions}\n[ ${screenController.missedPermissionStr} ]",
          onTap: _openAppSettings,
        ),
        ScanState.normal => Stack(
          children: [
            MobileScanner(
              tapToFocus: true,
              controller: screenController.scanController,
              onDetect: _onDetect,
            ),
            ValueListenableBuilder(
              valueListenable: screenController.detectListener,
              builder: (_, value, _) {
                return CenterQrDetectorAnimationWidget(
                  scanSize: context.mq.size.width * 0.72,
                  detected: screenController.isDetected,
                  barcodeCorners: screenController.detectedCorners,
                  cameraResolution: screenController.cameraResolution,
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  ToolBarCustomWidget(
                    tools: [
                      ToolBarData(
                        icon: AppIcons.galleryIcon,
                        onTap: _onPickFromGallery,
                        callDefaultOnTap: false,
                      ),
                      ToolBarData(
                        icon: AppIcons.cameraFlashIcon,
                        isSelectedListener: screenController.torchState,
                        onTap: (_) => screenController.toggleTorch(),
                      ),
                      ToolBarData(
                        icon: AppIcons.settingsIcon,
                        callDefaultOnTap: false,
                        onTap: _goToSettings,
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: screenController.detectListener,
                    builder: (_, detected, _) => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        screenController.isDetected
                            ? context.l.scanDetected
                            : context.l.scanHint,
                        key: ValueKey(detected),
                        style: TextStyle(
                          color: screenController.isDetected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                          fontWeight: screenController.isDetected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      },
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    final models = await screenController.onDetect(capture);
    if (mounted && models.isNotEmpty) {
      await context.goToDetails(models);
    }
  }

  Future<void> _onPickFromGallery(_) async {
    AppDialogs.showLoading(context, context.l.loading);
    final models = await screenController.pickFromGallery();
    if (!mounted) return;
    _suppressNextPopNext = true;
    AppDialogs.hideLoading(context);
    if (models == null) {
      AppDialogs.showNotifiyToast(context, context.l.permissionRequired);
      return;
    }
    if (models.isNotEmpty) {
      await context.goToDetails(models);
      return;
    }
    AppDialogs.showNotifiyToast(context, context.l.noBarCodeFoundInImageError);
  }

  Future<void> _goToSettings(_) async {
    await screenController.pauseCamera();
    if (mounted) {
      return context.goToSettings();
    }
  }

  Future<void> _openAppSettings() async {
    await screenController.pauseCamera();
    if (mounted) {
      await openAppSettings();
    }
  }

  void didPopNext() async {
    if (_suppressNextPopNext) {
      _suppressNextPopNext = false;
      return;
    }
    await screenController.applyPermissionStatus();
    screenController.resumeCamera();
  }

  void didPushNext() {
    screenController.pauseCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      screenController.applyPermissionStatus();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    screenController = ScanController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenController.init();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
