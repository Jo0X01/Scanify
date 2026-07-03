import 'package:flutter/material.dart';
import 'package:scanify/core/constants/app_assets.dart';
import 'package:scanify/core/enum/app_routes.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/core/enum/qr_source_type.dart';
import 'package:scanify/core/extensions/qrcode_model_icon.dart';
import 'package:scanify/core/managers/scanner_manager.dart';
import 'package:scanify/core/models/qrcode_model.dart';
import 'package:scanify/features/details/view/controller/details_controller.dart';
import 'package:scanify/features/details/view/widgets/action_button_custom_widget.dart'
    show ActionButtonCustomWidget;
import 'package:scanify/features/details/view/widgets/no_qr_data_widget.dart';
import 'package:scanify/features/details/view/widgets/qr_code_box_custom_widget.dart';
import 'package:scanify/shared/widgets/custom_back_appbar.dart';
import 'package:scanify/shared/widgets/qr_item_box_custom_widget.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, Set<QRCodeModel>? qrData})
    : _screenController = DetailsController(qrData);

  static const AppRouteKeys routeName = AppRouteKeys.detailsScreen;
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

    if (!widget._screenController.isJustOneQr) {
      return _manyQrTemplate(context);
    }

    final screenW = context.mq.size.width;
    final screenH = context.mq.size.height;
    final isTablet = screenW >= 600;
    final hPadding = screenW * 0.06;
    final cardRadius = isTablet ? 20.0 : 16.0;
    final qrSize = (screenW * 0.52).clamp(160.0, 200.0);

    return Scaffold(
      appBar: CustomBackAppBar(
        title: context.l.details,
        onBackPressed: () {},
        menuItems: [
          if (widget._screenController.canOpen)
            CustomAppbarMenuAction(
              icon: AppIcons.openIcon,
              title: context.l.open,
              onTap: _onOpenAction,
            ),
          CustomAppbarMenuAction(
            icon: AppIcons.saveIcon,
            title: context.l.save,
            onTap: () async => _onActionTake(
              widget._screenController.saveToGallery,
              context.l.savedSuccessfully,
              context.l.saveError,
            ),
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.shareIcon,
            title: context.l.share,
            onTap: widget._screenController.shareTo,
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.copyIcon,
            title: context.l.copyQrImage,
            onTap: () async => _onActionTake(
              widget._screenController.copyImageToClipboard,
              context.l.copiedToClipboard,
              context.l.error,
            ),
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.copyIcon,
            title: context.l.copyOriginalText,
            onTap: () async => _onActionTake(
              widget._screenController.copyTextToClipboard,
              context.l.copiedToClipboard,
              context.l.error,
            ),
          ),
          CustomAppbarMenuAction(
            icon: AppIcons.settingsIcon,
            title: context.l.settings,
            onTap: context.goToSettings,
          ),
          CustomAppbarMenuAction(
            iconData: Icons.info,
            title: context.l.summaryInfo,
            onTap: () async => AppDialogs.showSomeInfoInRowsDialog(
              context,
              title: context.l.summaryInfo,
              icon: widget._screenController.qrModel.icon,
              rows: _buildSummaryInfo(),
              closeText: context.l.okay,
              copyText: context.l.copy,
              onCopy: _onTextCopy,
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
                    onCopy: _onTextCopy,
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
                    label: context.l.open,
                    onTap: _onOpenAction,
                    quickBtn: false,
                  ),
                ActionButtonCustomWidget(
                  icon: AppIcons.shareIcon,
                  label: context.l.share,
                  onTap: widget._screenController.shareTo,
                ),
                ActionButtonCustomWidget(
                  icon: AppIcons.copyIcon,
                  label: context.l.copy,
                  onTap: () async => _onActionTake(
                    widget._screenController.copyImageToClipboard,
                    context.l.copiedToClipboard,
                    context.l.error,
                  ),
                ),
                ActionButtonCustomWidget(
                  icon: AppIcons.saveIcon,
                  label: context.l.save,
                  onTap: () async => _onActionTake(
                    widget._screenController.saveToGallery,
                    context.l.savedSuccessfully,
                    context.l.saveError,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _manyQrTemplate(BuildContext context) {
    final screenW = context.mq.size.width;
    final screenH = context.mq.size.height;
    final hPadding = screenW * 0.06;

    return Scaffold(
      appBar: CustomBackAppBar(title: context.l.details),
      body: ValueListenableBuilder(
        valueListenable: widget._screenController.qrDataListener,
        builder: (_, value, _) {
          if (widget._screenController.isQrDataEmpty) {
            return NoQrDataWidget();
          }
          final items = value.toList();
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
              item: items[i],
              onTap: () {
                context.goTo(DetailsScreen.routeName, arguments: {items[i]});
              },
            ),
          );
        },
      ),
    );
  }

  Map<String, String> _buildSummaryInfo() {
    final qr = widget._screenController.qrModel;
    return {
      context.l.scanSource:
          qr.source?.label(context.l) ?? context.l.scanSourceUknown,
      context.l.filterFormat:
          qr.format?.label(context.l) ?? context.l.formatUnknown,
      context.l.filterType: qr.type?.label(context.l) ?? context.l.typeUnknown,
      context.l.date:
          widget._screenController.getQrDate(qr) ?? context.l.dateUnknown,
      context.l.dataLength: (qr.data?.length ?? 0).toString(),
    };
  }

  void _onOpenAction() async {
    AppDialogs.showLoading(context, context.l.loading);
    await widget._screenController.openAction();
    if (!mounted) return;
    AppDialogs.hideLoading(context);
  }

  void _onTextCopy(String? val) async {
    if (val == null) {
      AppDialogs.showNotifiyToast(context, context.l.noDataProvided);
      return;
    }
    final isDone = await widget._screenController.copyTextToClipboard(val);
    if (mounted) {
      AppDialogs.showNotifiyToast(
        context,
        isDone ? context.l.copiedToClipboard : context.l.error,
      );
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
        AppDialogs.showNotifiyToast(context, success);
      } else {
        AppDialogs.showNotifiyToast(context, failed);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    ScannerManager.instance.clearDetection();
  }
}
