import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/utils/app_helpers.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/cusomt_painter_box_widget.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/scan_overlay_painter.dart';
import 'package:qrcode_scanner_app/features/scan/view/widgets/tool_bar_custom_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  static String routeName = AppRoutes.scanScreen;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final MobileScannerController _scannerController;
  late final ValueNotifier<bool> _detectedController;
  late final ImagePicker _imagePicker;

  String? _lastScannedValue;
  bool _isProcessing = false;

  late final AnimationController _scanLineController;
  late final AnimationController _pulseController;
  late final Animation<double> _scanLineAnimation;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scannerController = MobileScannerController();
    _detectedController = ValueNotifier(false);
    _imagePicker = ImagePicker();

    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isProcessing) return;
    switch (state) {
      case AppLifecycleState.paused:
        _scannerController.stop();
        break;
      case AppLifecycleState.resumed:
        _scannerController.start();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scanSize = MediaQuery.of(context).size.width * 0.72;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _onDetectBarcode,
          ),
          CustomPaint(
            size: Size.infinite,
            painter: ScanOverlayPainter(scanSize: scanSize),
          ),
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _scanLineAnimation,
                _detectedController,
                _pulseAnimation,
              ]),
              builder: (context, _) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: SizedBox(
                    width: scanSize,
                    height: scanSize,
                    child: CustomPaint(
                      painter: CusomtPainterBoxWidget(
                        detected: _detectedController.value,
                        scanLinePosition: _scanLineAnimation.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ToolBarCustomWidget(
            tools: [
              ToolBarData(
                icon: AppIcons.gallaryIcon,
                onTap: _pickImageFromGallery,
                callDefaultOnTap: false,
              ),
              ToolBarData(
                icon: AppIcons.cameraFlashIcon,
                onTap: _scannerController.toggleTorch,
              ),
              ToolBarData(
                icon: AppIcons.swapCamIcon,
                onTap: _scannerController.switchCamera,
              ),
              ToolBarData(
                icon: AppIcons.settingsIcon,
                onTap: _navigateToSettings,
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: ValueListenableBuilder<bool>(
                valueListenable: _detectedController,
                builder: (context, detected, _) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    detected
                        ? '✓ QR Code found!'
                        : 'Align QR code within the frame',
                    key: ValueKey(detected),
                    style: TextStyle(
                      color: detected
                          ? AppColors.primary
                          : Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                      fontWeight: detected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDetectBarcode(BarcodeCapture capture) {
    if (_isProcessing) return;

    final code = capture.barcodes
        .where((b) => b.rawValue != null && b.rawValue!.isNotEmpty)
        .firstOrNull;

    if (code == null) return;
    if (code.rawValue == _lastScannedValue) return;

    _isProcessing = true;
    _lastScannedValue = code.rawValue;
    
    _scannerController.stop();

    _detectedController.value = true;
    _pulseController.forward(from: 0);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) {
        _resetDetection();
        return;
      }
      _navigateToDetails(code);
    });
  }

  void _navigateToDetails(Barcode code) async {
    try {
      await AppRoutes.navigateTo(
        context,
        AppRoutes.detailsScreen,
        arguments: HistoryQRCodeModel(
          id: AppHelpers.generateMd5(code.rawValue!),
          data: code.rawValue,
          date: DateTime.now().millisecondsSinceEpoch,
          type: code.type.name,
        ),
      );
    } finally {
      _resetDetection();
    }
  }

  void _resetDetection() {
    if (!mounted) return;
    _isProcessing = false;
    _detectedController.value = false;
    _lastScannedValue = null;
    _scannerController.start();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (!mounted || image == null) return;

      final imageData = await _scannerController.analyzeImage(image.path);
      if (!mounted) return;

      final barcodes = imageData?.barcodes ?? [];
      if (barcodes.isNotEmpty) {
        final code = barcodes.firstWhere(
          (b) => b.rawValue != null && b.rawValue!.isNotEmpty,
        );
        _navigateToDetails(code);
        return;
      }
    } on Exception {
      /**/
    }

    if (mounted) {
      AppDialogs.showSnackBar(context, AppStrings.noBarCodeFoundInImageError);
    }
  }


  void _navigateToSettings() {
    AppRoutes.navigateTo(context, AppRoutes.settingsScreen);
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    _pulseController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _scannerController.dispose();
    _detectedController.dispose();
    super.dispose();
  }
}
