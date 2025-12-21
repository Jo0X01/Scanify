import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/utils/app_dialogs.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/cusomt_painter_box_widget.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/tool_bar_custom_widget.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({super.key});

  static const String routeName = AppRoutes.detailsScreen;
  bool captureMe = false;
  void captureNow() {
    captureMe = !captureMe;
  }

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
          MobileScanner(controller: controller, onDetect: _onDetectBarcode),
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
              child: CustomPaint(
                painter: CusomtPainterBoxWidget(detected: isDetected),
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
            ],
          ),
        ],
      ),
    );
  }

void _onDetectBarcode(BarcodeCapture barcode) {
  final String? code = barcode.barcodes.first.rawValue;
  if (code == null || isDetected) return;

  setState(() => isDetected = true);

  if (widget.captureMe) {
    Navigator.of(context).pushNamed(AppRoutes.detailsScreen, arguments: code);
  }
  Future.delayed(const Duration(seconds: 1), () {
    if (mounted) {
      setState(() => isDetected = false);
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
      AppRoutes.navigateTo(
        context,
        AppRoutes.detailsScreen,
        arguments: barcodes.firstWhere(
          (b) => b.rawValue != null && b.rawValue!.isNotEmpty,
        ),
      );
    } else {
      AppDialogs.showSnackBar(context, AppStrings.noBarCodeFoundInImageError);
    }
  }

  late MobileScannerController controller;
  late final ImagePicker _picker;
  late bool isDetected;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    _picker = ImagePicker();
    isDetected = false;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
