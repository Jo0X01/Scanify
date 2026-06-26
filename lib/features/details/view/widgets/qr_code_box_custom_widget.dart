import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/extensions/qrcode_model_viewer.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/constants/app_helpers.dart';
import 'package:qrcode_scanner_app/shared/widgets/meta_text_custom_widget.dart';
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
    required this.qrVersion,
    required this.showFullText,
    this.locale,
    this.qrShape,
  });

  final QRCodeModel qrData;
  final double cardRadius;
  final double qrSize;
  final double hPadding;
  final void Function(String? data) onCopy;
  final PrettyQrShape? qrShape;
  final ScreenshotController saveController;
  final int qrVersion;
  final String? locale;
  final bool showFullText;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final l = AppLocalizations.of(context)!;
    return Container(
      alignment: Alignment.center,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTags(l),
          SizedBox(height: screenH * 0.018),
          Screenshot(
            controller: saveController,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lDivider,
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(cardRadius * 0.75),
              ),
              child: SizedBox(
                width: qrSize,
                child: PrettyQrView.data(
                  data: qrData.data ?? '',
                  errorCorrectLevel: qrVersion,
                  decoration: PrettyQrDecoration(
                    shape: PrettyQrShape.custom(
                      qrShape ?? const PrettyQrSmoothSymbol(),
                    ),
                    quietZone: const PrettyQrQuietZone.pixels(10),
                    image: const PrettyQrDecorationImage(
                      image: AssetImage(AppImages.appLogo),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenH * 0.014),
          Text(
            AppHelpers.getReadableDate(qrData.date, locale: locale),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: screenH * 0.02),

          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: screenH * 0.02),
          _buildQrData(context, l),
        ],
      ),
    );
  }

  Widget _buildTags(AppLocalizations l) {
    List<Widget> tags = [];
    if (qrData.type != null) {
      tags.add(MetaTextCustomWidget(label: qrData.type!.label(l)));
    }
    if (qrData.source != null) {
      tags.add(MetaTextCustomWidget(label: qrData.source!.label(l)));
    }
    if (qrData.format != null) {
      tags.add(MetaTextCustomWidget(label: qrData.format!.label(l)));
    }
    if (tags.isEmpty) {
      return SizedBox.shrink();
    }
    return Wrap(spacing: 8, runSpacing: 8, children: tags);
  }

  Column _buildQrData(BuildContext context, AppLocalizations l) {
    final viewData = qrData.viewData(l);
    if (viewData == null) {
      return Column(
        children: [
          GestureDetector(
            onTap: () => onCopy(qrData.data),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const Icon(Icons.copy_rounded, size: 18),
                Flexible(
                  child: Text(
                    qrData.data ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: showFullText ? null : TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      spacing: 15,
      children: viewData.entries
          .map(
            (ele) => GestureDetector(
              onTap: () => onCopy(ele.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                // spacing: 25,
                children: [
                  Flexible(
                    child: Text(
                      "${ele.key} : ",
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.left,
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Text(
                        ele.value ?? l.typeUnknown,
                        overflow: TextOverflow.ellipsis,
                        // textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                      const Icon(Icons.copy_rounded, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
