import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/extensions/qrcode_model_icon.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/constants/app_helpers.dart';
import 'package:qrcode_scanner_app/shared/widgets/meta_text_custom_widget.dart';

class QrItemBoxCustomWidget extends StatelessWidget {
  const QrItemBoxCustomWidget({
    super.key,
    required this.item,
    required this.onTap,
    this.onDelete,
    this.enableDelete = true,
  });

  final QRCodeModel item;
  final VoidCallback onTap;
  final bool enableDelete;
  final void Function(QRCodeModel)? onDelete;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary,
              blurRadius: 3,
              spreadRadius: 1.2,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      SvgPicture.asset(
                        item.icon,
                        width: 25,
                        height: 25,
                        theme: SvgTheme(
                          currentColor: theme.colorScheme.primary,
                        ),
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      if (item.data != null)
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                item.data!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: theme.textTheme.labelLarge,
                              ),
                              Text(
                                AppHelpers.getReadableDate(
                                  item.date,
                                  locale: l.localeName,
                                ),
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        MetaTextCustomWidget(
                          label: item.source?.label(l) ?? l.scanSourceUknown,
                          fontSize: 8,
                        ),
                        if (item.format != null)
                          MetaTextCustomWidget(
                            label: item.format!.label(l),
                            fontSize: 8,
                          ),
                        if (item.type != null)
                          MetaTextCustomWidget(
                            label: item.type!.label(l),
                            fontSize: 8,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (enableDelete)
              IconButton(
                onPressed: () => AppDialogs.showConfirm(
                  context,
                  title: l.delete,
                  content: l.askOnDeleteMessage,
                  onConfirm: () => onDelete?.call(item),
                ),
                icon: SvgPicture.asset(
                  AppIcons.trashIcon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.error,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
