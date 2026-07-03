import 'package:flutter/material.dart';
import 'package:scanify/core/enum/app_routes.dart' show AppRouteKeys;
import 'package:scanify/core/enum/qr_source_type.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/features/history/view/controller/history_controller.dart';
import 'package:scanify/features/history/view/widgets/history_empty_custom_widget.dart';
import 'package:scanify/shared/widgets/qr_item_box_custom_widget.dart';
import 'package:scanify/shared/widgets/custom_back_appbar.dart';
import 'package:scanify/shared/widgets/meta_text_custom_widget.dart';
import 'package:scanify/shared/widgets/search_bar_custom_widget.dart';
import 'package:scanify/shared/widgets/selected_filter_custom_widget.dart'
    show SelectedFilterCustomWidget;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  static const routeName = AppRouteKeys.historyScreen;

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  late final HistoryController screenController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBackAppBar(
          kbHeight: context.mq.size.height / 12,
          title: context.l.history,
          hasBack: false,
          addSettings: true,
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: screenController.itemListener,
            builder: (_, items, _) {
              return GestureDetector(
                onTap: FocusManager.instance.primaryFocus?.unfocus,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    SearchBarCustomWidget(
                      hintText: context.l.search,
                      enableFilter: true,
                      margin: const EdgeInsets.only(top: 10),
                      controller: screenController.searchInputController,
                      enabled:
                          (!screenController.isFilterCleared &&
                              items.isEmpty) ||
                          screenController.isFilterCleared && items.isEmpty ||
                          items.isNotEmpty,
                      onChange: (_) => screenController.loadData(),
                      onFilter: () {
                        SelectedFilterCustomWidget.showSelectedDialog(
                          context,
                          title: context.l.filter,
                          onApply: screenController.setFilters,
                          applyText: context.l.apply,
                          selectedIndexes: {
                            context.l.scanSource: screenController.scanFilters,
                            context.l.filterType: screenController.typeFilters,
                            context.l.filterFormat:
                                screenController.formatFilters,
                          },
                          groupItems: {
                            context.l.scanSource: QrSourceType.asMapLabel(
                              context.l,
                            ),
                            context.l.filterType: XBarCodeType.asMapLabel(
                              context.l,
                            ),
                            context.l.filterFormat: XBarCodeFormat.asMapLabel(
                              context.l,
                            ),
                          },
                        );
                      },
                    ),
                    if (!screenController.isFilterCleared)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          spacing: 8,
                          children: [
                            MetaTextCustomWidget(
                              mode: MetaTextMode.tap,
                              label: context.l.clear,
                              isDestructive: true,
                              leadingIcon: Icons.close_sharp,
                              radius: 20,
                              fontSize: 10,
                              onToggle: (_) => screenController.clearFilters(),
                            ),
                            ...screenController.scanFilters.map(
                              (tag) => MetaTextCustomWidget(
                                label: tag.label(context.l),
                                mode: MetaTextMode.tap,
                                radius: 20,
                                fontSize: 10,
                                onToggle: (value) =>
                                    screenController.removeFilter(tag),
                              ),
                            ),
                            ...screenController.typeFilters.map(
                              (tag) => MetaTextCustomWidget(
                                label: tag.label(context.l),
                                mode: MetaTextMode.tap,
                                radius: 20,
                                fontSize: 10,
                                onToggle: (value) =>
                                    screenController.removeFilter(tag),
                              ),
                            ),
                            ...screenController.formatFilters.map(
                              (tag) => MetaTextCustomWidget(
                                label: tag.label(context.l),
                                mode: MetaTextMode.tap,
                                radius: 20,
                                fontSize: 10,
                                onToggle: (value) =>
                                    screenController.removeFilter(tag),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: screenController.loadData,
                        child: items.isEmpty
                            ? screenController.isFilterCleared
                                  ? _noDataExist()
                                  : _noDataExistSearch()
                            : ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(
                                  16,
                                  12,
                                  16,
                                  context.mq.size.height * 0.15,
                                ),
                                itemCount: items.length,
                                itemBuilder: (_, i) => QrItemBoxCustomWidget(
                                  item: items[i],
                                  onDelete: screenController.deleteItem,
                                  onTap: () => context.goToDetails({items[i]}),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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

  @override
  void initState() {
    super.initState();
    screenController = HistoryController();
  }

  @override
  void dispose() {
    screenController.dispose();
    super.dispose();
  }
}
