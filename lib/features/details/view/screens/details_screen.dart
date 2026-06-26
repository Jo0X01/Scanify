import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/extensions/qrcode_model_icon.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/features/details/view/controller/details_controller.dart';
import 'package:qrcode_scanner_app/features/details/view/widgets/action_button_custom_widget.dart'
    show ActionButtonCustomWidget;
import 'package:qrcode_scanner_app/features/details/view/widgets/no_qr_data_widget.dart';
import 'package:qrcode_scanner_app/features/details/view/widgets/qr_code_box_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart';
import 'package:qrcode_scanner_app/shared/widgets/qr_item_box_custom_widget.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, List<QRCodeModel>? qrData})
    : _screenController = DetailsController(qrData);

  static const String routeName = AppRoutes.detailsScreen;
  final DetailsController _screenController;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget._screenController.isQrDataEmpty) {
      return NoQrDataWidget();
    }

    final l = AppLocalizations.of(context)!;

    if (!widget._screenController.isJustOneQr) {
      return _manyQrTemplate(context, l);
    }

    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final isTablet = screenW >= 600;
    final hPadding = screenW * 0.06;
    final cardRadius = isTablet ? 20.0 : 16.0;
    final qrSize = (screenW * 0.52).clamp(160.0, 200.0);

    return Scaffold(
      appBar: CustomBackAppBar(
        title: l.details,
        onBackPressed: () {},
        menuItems: [
          if (widget._screenController.canOpen)
            CustomAppbarMenuAction(
              icon: AppIcons.openIcon,
              title: l.open,
              onTap: () => _onOpenAction(l),
            ),
          CustomAppbarMenuAction(
            icon: AppIcons.saveIcon,
            title: l.save,
            onTap: () async => _onActionTake(
              widget._screenController.saveToGallery,
              l.savedSuccessfully,
              l.saveError,
            ),
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.shareIcon,
            title: l.share,
            onTap: widget._screenController.shareTo,
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.copyIcon,
            title: l.copyQrImage,
            onTap: () async => _onActionTake(
              widget._screenController.copyImageToClipboard,
              l.copiedToClipboard,
              l.error,
            ),
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.copyIcon,
            title: l.copyOriginalText,
            onTap: () async => _onActionTake(
              widget._screenController.copyTextToClipboard,
              l.copiedToClipboard,
              l.error,
            ),
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.settingsIcon,
            title: l.settings,
            onTap: () async => AppRoutes.navigateToSettings(context),
          ),
          CustomAppbarMenuAction(
            iconData: Icons.info,
            title: l.summaryInfo,
            onTap: () async => AppDialogs.showSomeInfoInRowsDialog(
              context,
              title: l.summaryInfo,
              icon: widget._screenController.qrModel.icon,
              rows: _buildSummaryInfo(l),
              closeText: l.okay,
              copyText: l.copy,
              onCopy: (val) => _onTextCopy(l, val),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: hPadding,
          right: hPadding,
          top: screenH * 0.02,
          bottom: screenH * 0.05,
        ),
        child: Column(
          spacing: screenH * 0.020,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(cardRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  QrCodeBoxCustomWidget(
                    cardRadius: cardRadius,
                    qrSize: qrSize,
                    hPadding: hPadding,
                    qrData: widget._screenController.qrModel,
                    qrVersion: widget._screenController.errorCorrectionLevel,
                    saveController:
                        widget._screenController.screenshotController,
                    locale: widget._screenController.locale,
                    showFullText: widget._screenController.showAllDetails,
                    onCopy: (val) => _onTextCopy(l, val),
                  ),
                ],
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                if (widget._screenController.canOpen)
                  ActionButtonCustomWidget(
                    icon: AppIcons.openIcon,
                    label: l.open,
                    onTap: () => _onOpenAction(l),
                    quickBtn: false,
                  ),
                ActionButtonCustomWidget(
                  icon: AppIcons.shareIcon,
                  label: l.share,
                  onTap: widget._screenController.shareTo,
                ),
                ActionButtonCustomWidget(
                  icon: AppIcons.copyIcon,
                  label: l.copy,
                  onTap: () async => _onActionTake(
                    widget._screenController.copyImageToClipboard,
                    l.copiedToClipboard,
                    l.error,
                  ),
                ),
                ActionButtonCustomWidget(
                  icon: AppIcons.saveIcon,
                  label: l.save,
                  onTap: () async => _onActionTake(
                    widget._screenController.saveToGallery,
                    l.savedSuccessfully,
                    l.saveError,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _manyQrTemplate(BuildContext context, AppLocalizations l) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final hPadding = screenW * 0.06;

    return Scaffold(
      appBar: CustomBackAppBar(title: l.details),
      body: ValueListenableBuilder(
        valueListenable: widget._screenController.qrDataListener,
        builder: (_, value, _) {
          if (widget._screenController.isQrDataEmpty) {
            return NoQrDataWidget();
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(
              hPadding,
              screenH * 0.02,
              hPadding,
              screenH * 0.05,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: widget._screenController.qrLength,
            itemBuilder: (_, i) => QrItemBoxCustomWidget(
              onDelete: (item) =>
                  widget._screenController.removeQrByIndex(item),
              item: value![i],
              onTap: () {
                AppRoutes.navigateTo(
                  context,
                  DetailsScreen.routeName,
                  arguments: [value[i]],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Map<String, String> _buildSummaryInfo(AppLocalizations l) {
    final qr = widget._screenController.qrModel;
    return {
      l.scanSource: qr.source?.label(l) ?? l.scanSourceUknown,
      l.filterFormat: qr.format?.label(l) ?? l.formatUnknown,
      l.filterType: qr.type?.label(l) ?? l.typeUnknown,
      l.date: widget._screenController.getQrDate(qr) ?? l.dateUnknown,
      l.dataLength: (qr.data?.length ?? 0).toString(),
    };
  }

  void _onOpenAction(AppLocalizations l) async {
    AppDialogs.showLoading(context, l.loading);
    await widget._screenController.openAction();
    if (!mounted) return;
    AppDialogs.hideLoading(context);
  }

  void _onTextCopy(AppLocalizations l, String? val) async {
    if (val == null) {
      AppDialogs.showSnackBar(context, l.noDataProvided);
      return;
    }
    if (await widget._screenController.copyTextToClipboard(val) && mounted) {
      AppDialogs.showSnackBar(context, l.copiedToClipboard);
    } else {
      AppDialogs.showSnackBar(context, l.error);
    }
  }

  void _onActionTake(
    Future<bool> Function() action,
    String success,
    String failed,
  ) async {
    final isDone = await action();
    if (mounted) {
      if (isDone) {
        AppDialogs.showSnackBar(context, success);
      } else {
        AppDialogs.showSnackBar(context, failed);
      }
    }
  }
}
