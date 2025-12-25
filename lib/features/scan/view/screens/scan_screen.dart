import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/utils/app_helpers.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/cusomt_painter_box_widget.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/tool_bar_custom_widget.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({super.key});
  static const String routeName = AppRoutes.detailsScreen;
  final ValueNotifier<bool> captureTrigger = ValueNotifier(false);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    final double scanSize = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            overlayBuilder: (context, constraints) {
              return ValueListenableBuilder<bool>(
                valueListenable: isDetectedController,
                builder: (context, value, child) {
                  return Text(
                    isDetectedController.value ? "Tap To Scan" : "Waiting...",
                  );
                },
              );
            },
            onDetect: _onDetectBarcode,
          ),
          Center(
            child: Container(
              width: scanSize,
              height: scanSize,
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          Container(color: Colors.black54),
          Center(
            child: SizedBox(
              width: scanSize,
              height: scanSize,
              child: ValueListenableBuilder<bool>(
                valueListenable: isDetectedController,
                builder: (context, isDetected, _) => CustomPaint(
                  painter: CusomtPainterBoxWidget(detected: isDetected),
                ),
              ),
            ),
          ),
          ToolBarCustomWidget(
            tools: [
              ToolBarData(
                icon: AppIcons.gallaryIcon,
                onTap: pickImageFromGallery,
                callDefaultOnTap: false,
              ),
              ToolBarData(
                icon: AppIcons.cameraFlashIcon,
                onTap: controller.toggleTorch,
              ),
              ToolBarData(
                icon: AppIcons.swapCamIcon,
                onTap: controller.switchCamera,
              ),
              ToolBarData(
                icon: AppIcons.settingsIcon,
                onTap: _navigateToSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToSettings() {
    AppRoutes.navigateTo(context, AppRoutes.settingsScreen);
  }

  void _onDetectBarcode(BarcodeCapture barcode) async {
    final Barcode code = barcode.barcodes.first;
    if (code.rawValue == null) return;

    isDetectedController.value = true;

    if (_shouldCapture) {
      _shouldCapture = false;
      isDetectedController.value = false;
      if (controller.torchEnabled) {
        await controller.toggleTorch();
      }
      _parseAndNavigate(code);
      return;
    }
    _shouldCapture = false;
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        isDetectedController.value = false;
      }
    });
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (!mounted || image == null) return;
    final imageData = await controller.analyzeImage(image.path);
    if (!mounted) return;
    final barcodes = imageData?.barcodes ?? [];
    if (barcodes.isNotEmpty) {
      _parseAndNavigate(
        barcodes.firstWhere(
          (b) => b.rawValue != null && b.rawValue!.isNotEmpty,
        ),
      );
    } else {
      AppDialogs.showSnackBar(context, AppStrings.noBarCodeFoundInImageError);
    }
  }

  void _parseAndNavigate(Barcode code) {
    Navigator.of(context).pushNamed(
      AppRoutes.detailsScreen,
      arguments: HistoryQRCodeModel(
        id: AppHelpers.generateMd5(code.rawValue!),
        data: code.rawValue,
        date: DateTime.now().millisecondsSinceEpoch,
        type: code.type.name,
      ),
    );
  }

  late MobileScannerController controller;
  late ValueNotifier<bool> isDetectedController;
  late final ImagePicker _picker;
  late bool _shouldCapture = false;
  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      
    );
    isDetectedController = ValueNotifier(false);
    _picker = ImagePicker();
    widget.captureTrigger.addListener(() {
      if (widget.captureTrigger.value) {
        _shouldCapture = true;
      }
    });
  }
  

  @override
  void dispose() {
    controller.dispose();
    isDetectedController.dispose();
    super.dispose();
  }
}
