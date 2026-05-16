import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/utils/app_helpers.dart';
import 'package:qrcode_scanner_app/features/details/view/widgets/meta_text_custom_widget.dart';
import 'package:screenshot/screenshot.dart';

class QrCodeBoxCustomWidget extends StatelessWidget {
  const QrCodeBoxCustomWidget({
    super.key,
    required this.qrData,
    required this.cardRadius,
    required this.qrSize,
    required this.hPadding,
    required this.onCopy,
    required this.saveController,
  });

  final HistoryQRCodeModel qrData;
  final double cardRadius;
  final double qrSize;
  final double hPadding;
  final VoidCallback onCopy;
  final ScreenshotController saveController;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenH = mq.size.height;

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: screenH * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onCopy,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    qrData.data ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.copy_rounded,
                  size: 15,
                  color: AppColors.iconColor,
                ),
              ],
            ),
          ),

          SizedBox(height: screenH * 0.025),

          const Divider(height: 1, thickness: 1, color: AppColors.divider),
          SizedBox(height: screenH * 0.025),
          Screenshot(
            controller: saveController,
            child: Container(
              padding: EdgeInsets.all(qrSize * 0.06),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(cardRadius * 0.75),
              ),
              child: QrImageView(
                data: qrData.data ?? '',
                size: qrSize,
                embeddedImage: const AssetImage(AppImages.appLogo),
                backgroundColor: AppColors.background,
                version: QrVersions.auto,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
              ),
            ),
          ),

          SizedBox(height: screenH * 0.025),

          const Divider(height: 1, thickness: 1, color: AppColors.divider),

          SizedBox(height: screenH * 0.025),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MetaTextCustomWidget(label: qrData.type ?? 'Unknown'),
              Text(
                AppHelpers.getCleanDate(qrData.date),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
