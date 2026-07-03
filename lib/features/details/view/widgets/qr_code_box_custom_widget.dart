import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:scanify/core/constants/app_assets.dart';
import 'package:scanify/core/enum/qr_source_type.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/extensions/qrcode_model_viewer.dart';
import 'package:scanify/core/models/qrcode_model.dart';
import 'package:scanify/core/constants/app_helpers.dart';
import 'package:scanify/shared/widgets/meta_text_custom_widget.dart';
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
    final screenH = context.mq.size.height;
  
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: screenH * 0.03,
      ),
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceBright,
        border: Border.all(color: context.colorTheme.outline),
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTags(context),
          SizedBox(height: screenH * 0.018),
          Screenshot(
            controller: saveController,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: context.colorTheme.outline),
                borderRadius: BorderRadius.circular(cardRadius * 0.75),
              ),
              child: SizedBox(
                width: qrSize,
                child: PrettyQrView.data(
                  data: qrData.data ?? '',
                  errorCorrectLevel: qrVersion,
                  decoration: PrettyQrDecoration(
                    // ignore: experimental_member_use
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
            style: context.theme.textTheme.bodyMedium,
          ),
          SizedBox(height: screenH * 0.02),

          Divider(
            height: 1,
            thickness: 1,
            color: context.colorTheme.primary,
          ),
          SizedBox(height: screenH * 0.02),
          _buildQrData(context),
        ],
      ),
    );
  }

  Widget _buildTags(BuildContext context) {
    List<Widget> tags = [];
    if (qrData.type != null) {
      tags.add(MetaTextCustomWidget(label: qrData.type!.label(context.l)));
    }
    if (qrData.source != null) {
      tags.add(MetaTextCustomWidget(label: qrData.source!.label(context.l)));
    }
    if (qrData.format != null) {
      tags.add(MetaTextCustomWidget(label: qrData.format!.label(context.l)));
    }
    if (tags.isEmpty) {
      return SizedBox.shrink();
    }
    return Wrap(spacing: 8, runSpacing: 8, children: tags);
  }

  Column _buildQrData(BuildContext context) {
    final viewData = qrData.viewData(context.l);
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
                        ele.value ?? context.l.typeUnknown,
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
