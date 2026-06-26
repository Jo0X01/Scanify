
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/features/scan/view/controller/scan_controller.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/center_qr_detector_widget.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/tool_bar_custom_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  static String routeName = AppRoutes.scanScreen;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late final ScanController screenController;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final scanSize = MediaQuery.of(context).size.width * 0.72;
    final controller = screenController.controller;

    if (controller == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            tapToFocus: true,
            controller: controller,
            onDetect: (bar) => _onDetect(bar, l),
          ),
          ValueListenableBuilder(
            valueListenable: screenController.detectListener,
            builder: (_, value, _) {
              return CenterQrDetectorAnimationWidget(
                scanSize: scanSize,
                detected: value,
                barcodeCorners: screenController.detectedCorners,
                cameraResolution: screenController.controller?.value.size,
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
                      onTap: () => _onPickFromGallery(l),
                      callDefaultOnTap: false,
                    ),
                    ToolBarData(
                      icon: AppIcons.cameraFlashIcon,
                      onTap: screenController.toggleTorch,
                    ),
                    ToolBarData(
                      icon: AppIcons.settingsIcon,
                      callDefaultOnTap: false,
                      onTap: () =>
                          AppRoutes.navigateTo(context, AppRoutes.settingsScreen),
                    ),
                  ],
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: screenController.detectListener,
                  builder: (_, detected, _) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      detected ? l.scanDetected : l.scanHint,
                      key: ValueKey(detected),
                      style: TextStyle(
                        color: detected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                        fontWeight: detected
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
    );
  }

  Future<void> _onDetect(BarcodeCapture capture, AppLocalizations l) async {
    debugPrint('ScanScreen._onDetect: ${capture.barcodes.length} barcodes');
    for (final b in capture.barcodes) {
      debugPrint('barcode: ${b.rawValue} format: ${b.format}');
    }
    final models = await screenController.onDetect(capture);
    if (!mounted) return;
    if (models != null) {
      await AppRoutes.navigateTo(
        context,
        AppRoutes.detailsScreen,
        arguments: models,
      );
    }
  }

  Future<void> _onPickFromGallery(AppLocalizations l) async {
    AppDialogs.showLoading(context, l.loading);
    final models = await screenController.pickFromGallery();
    if (!mounted) return;
    AppDialogs.hideLoading(context);
    if (models?.isNotEmpty ?? false) {
      await AppRoutes.navigateTo(
        context,
        AppRoutes.detailsScreen,
        arguments: models,
      );
    } else {
      AppDialogs.showSnackBar(context, l.noBarCodeFoundInImageError);
    }
  }

  @override
  void initState() {
    super.initState();
    screenController = ScanController();
  }

  @override
  void dispose() {
    screenController.dispose();
    super.dispose();
  }
}
