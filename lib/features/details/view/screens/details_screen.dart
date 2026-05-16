import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_toasts.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/services/hive_service.dart';
import 'package:qrcode_scanner_app/features/details/view/widgets/action_buttom_custom_widget.dart';
import 'package:qrcode_scanner_app/features/details/view/widgets/qr_code_box_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.qrData});
  static const String routeName = AppRoutes.detailsScreen;
  final HistoryQRCodeModel? qrData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ScreenshotController _saveController = ScreenshotController();

  HistoryQRCodeModel? get _qrData => widget.qrData;

  @override
  void initState() {
    super.initState();
    _persistIfNeeded();
  }

  void _persistIfNeeded() {
    final data = _qrData;
    if (data == null || data.id == null) return;
    HiveService.put<HistoryQRCodeModel>(data.id!, data);
  }

  @override
  Widget build(BuildContext context) {
    if (_qrData == null) {
      return Scaffold(
        appBar: CustomBackAppBar(title: AppStrings.details),
        body: Center(
          child: Text(
            'No data provided.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    final mq = MediaQuery.of(context);
    final screenW = mq.size.width;
    final screenH = mq.size.height;
    final isTablet = screenW >= 600;

    final hPadding = screenW * 0.06;
    final cardRadius = isTablet ? 20.0 : 16.0;
    final qrSize = (screenW * 0.52).clamp(160.0, 280.0);
    final btnSize = (screenW * 0.14).clamp(50.0, 72.0);
    final btnPad = btnSize * 0.22;

    return Scaffold(
      appBar: CustomBackAppBar(title: AppStrings.details),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: hPadding,
          right: hPadding,
          top: screenH * 0.02,
          bottom: screenH * 0.05,
        ),
        child: Column(
          spacing: screenH * 0.025,
          children: [
            QrCodeBoxCustomWidget(
              cardRadius: cardRadius,
              qrSize: qrSize,
              hPadding: hPadding,
              qrData: _qrData!,
              onCopy: _copyTextToClipboard,
              saveController: _saveController,
            ),
            _buildActionButtons(
              context,
              btnSize: btnSize,
              btnPad: btnPad,
              isTablet: isTablet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context, {
    required double btnSize,
    required double btnPad,
    required bool isTablet,
  }) {
    final buttons = [
      (AppIcons.shareIcon, AppStrings.share, _share),
      (AppIcons.copyIcon, AppStrings.copy, _copyTextToClipboard),
      (AppIcons.saveIcon, AppStrings.save, _save),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map(
            (b) => ActionButtonCustomWidget(
              icon: b.$1,
              label: b.$2,
              onTap: b.$3,
              size: btnSize,
              padding: btnPad,
            ),
          )
          .toList(),
    );
  }

  void _copyTextToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _qrData!.data!));
    if (mounted) AppDialogs.showSnackBar(context, 'Copied to clipboard');
  }

  void _share() async {
    AppDialogs.showSnackBar(context, 'Sharing...');
    try {
      final tempDir = await getTemporaryDirectory();
      final image = await _saveController.captureAndSave(
        tempDir.path,
        fileName: AppStrings.tempShareQRFileName,
      );
      if (image == null) throw Exception('Failed to capture QR image');

      final result = await SharePlus.instance.share(
        ShareParams(files: [XFile(image)]),
      );
      if (mounted && result.status == ShareResultStatus.success) {
        AppDialogs.showSnackBar(context, 'Shared successfully');
      }
    } catch (e) {
      if (mounted) {
        AppToast.warn(context, title: 'Error', description: e.toString());
      }
    }
  }

  void _save() async {
    AppDialogs.showSnackBar(context, 'Saving...');
    try {
      final path = await _saveController.captureAndSave(AppStrings.cameraPath);
      if (mounted) {
        AppDialogs.showSnackBar(
          context,
          path != null ? 'Saved to: $path' : 'Save failed',
        );
      }
    } catch (e) {
      if (mounted) {
        AppToast.warn(context, title: 'Save Error', description: e.toString());
      }
    }
  }
}
