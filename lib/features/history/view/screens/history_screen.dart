import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/features/history/view/controller/history_controller.dart';
import 'package:qrcode_scanner_app/features/history/view/widgets/history_empty_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/qr_item_box_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/custom_back_appbar.dart';
import 'package:qrcode_scanner_app/shared/widgets/meta_text_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/search_bar_custom_widget.dart';
import 'package:qrcode_scanner_app/shared/widgets/selected_filter_custom_widget.dart'
    show SelectedFilterCustomWidget;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  static const String routeName = AppRoutes.historyScreen;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryController _screenController;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final mq = MediaQuery.of(context);
    final bottomPadding = mq.padding.bottom;

    return Scaffold(
      appBar: CustomBackAppBar(
        kbHeight: mq.size.height / 14,
        title: l.history,
        hasBack: false,
        addSettings: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: _screenController.itemListener,
        builder: (_, items, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              SearchBarCustomWidget(
                hintText: l.search,
                enableFilter: true,
                margin: const EdgeInsets.only(top: 10),
                controller: _screenController.searchInputController,
                enabled:
                    (!_screenController.isFilterCleared && items.isEmpty) ||
                    _screenController.isFilterCleared && items.isEmpty ||
                    items.isNotEmpty,
                onChange: (_) => _screenController.loadData(),
                onFilter: () {
                  SelectedFilterCustomWidget.showSelectedDialog(
                    context,
                    title: l.filter,
                    onApply: _screenController.setFilters,
                    applyText: l.apply,
                    selectedIndexes: {
                      l.scanSource: _screenController.scanFilters,
                      l.filterType: _screenController.typeFilters,
                      l.filterFormat: _screenController.formatFilters
                    },
                    groupItems: {
                      l.scanSource: QrSourceType.asMapLabel(l),
                      l.filterType: XBarCodeType.asMapLabel(l),
                      l.filterFormat: XBarCodeFormat.asMapLabel(l),
                    },
                  );
                },
              ),
              if (!_screenController.isFilterCleared)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    spacing: 8,
                    children: [
                      MetaTextCustomWidget(
                        mode: MetaTextMode.tap,
                        label: l.clear,
                        isDestructive: true,
                        leadingIcon: Icons.close_sharp,
                        radius: 20,
                        fontSize: 10,
                        onToggle: (_) => _screenController.clearFilters(),
                      ),
                      ..._screenController.scanFilters.map(
                        (tag) => MetaTextCustomWidget(
                          label: tag.label(l),
                          mode: MetaTextMode.tap,
                          radius: 20,
                          fontSize: 10,
                          onToggle: (value) =>
                              _screenController.removeFilter(tag),
                        ),
                      ),
                      ..._screenController.typeFilters.map(
                        (tag) => MetaTextCustomWidget(
                          label: tag.label(l),
                          mode: MetaTextMode.tap,
                          radius: 20,
                          fontSize: 10,
                          onToggle: (value) =>
                              _screenController.removeFilter(tag),
                        ),
                      ),
                      ..._screenController.formatFilters.map(
                        (tag) => MetaTextCustomWidget(
                          label: tag.label(l),
                          mode: MetaTextMode.tap,
                          radius: 20,
                          fontSize: 10,
                          onToggle: (value) =>
                              _screenController.removeFilter(tag),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _screenController.loadData,
                  child: items.isEmpty
                      ? _screenController.isFilterCleared
                            ? _noDataExist()
                            : _noDataExistSearch()
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(
                            16,
                            12,
                            16,
                            bottomPadding + 20,
                          ),

                          itemCount: items.length,
                          itemBuilder: (_, i) => QrItemBoxCustomWidget(
                            item: items[i],
                            onDelete: _screenController.deleteItem,
                            onTap: () => _onItemClick(arg: [items[i]]),
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _noDataExist() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: const HistoryEmptyCustomWidget(),
    );
  }

  Widget _noDataExistSearch() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: const HistoryEmptyCustomWidget(isSearch: true),
    );
  }

  void _onItemClick({required Object? arg}) {
    AppRoutes.navigateTo(context, AppRoutes.detailsScreen, arguments: arg);
  }

  @override
  void initState() {
    super.initState();
    _screenController = HistoryController();
  }

  @override
  void dispose() {
    _screenController.dispose();
    super.dispose();
  }
}
