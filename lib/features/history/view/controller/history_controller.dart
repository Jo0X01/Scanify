import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanify/core/enum/qr_source_type.dart';
import 'package:scanify/core/managers/notification_manager.dart';
import 'package:scanify/core/managers/scanner_manager.dart';
import 'package:scanify/core/models/qrcode_model.dart';

class HistoryController {
  late final ValueNotifier<List<QRCodeModel>> _items;
  late final TextEditingController _searchTextController;
  late final Set<QrSourceType> _scanFilters;
  late final Set<BarcodeType> _typeFilters;
  late final Set<BarcodeFormat> _formatFilters;

  HistoryController() {
    _searchTextController = TextEditingController();
    _items = ValueNotifier<List<QRCodeModel>>([]);
    _scanFilters = {};
    _typeFilters = {};
    _formatFilters = {};

    loadData();
    ScannerManager.instance.setListenerToSavedQr(loadData);
  }

  Set<QrSourceType> get scanFilters => _scanFilters;
  Set<BarcodeType> get typeFilters => _typeFilters;
  Set<BarcodeFormat> get formatFilters => _formatFilters;

  bool get isFilterCleared =>
      (_scanFilters.isEmpty && _formatFilters.isEmpty && _typeFilters.isEmpty);

  Set<String> get filterTags => {
    ..._scanFilters.map((ele) => ele.name),
    ..._formatFilters.map((ele) => ele.name),
    ..._typeFilters.map((ele) => ele.name),
  };

  ValueNotifier<List<QRCodeModel>> get itemListener => _items;
  TextEditingController get searchInputController => _searchTextController;

  void applyFilterAndLoad() {
    _items.value = ScannerManager.instance.getSavedQrModels(
      (ele) =>
          ((_searchTextController.text.isEmpty ||
              ele.data?.toLowerCase().contains(
                    _searchTextController.text.toLowerCase(),
                  ) ==
                  true) &&
          (_scanFilters.isEmpty || _scanFilters.contains(ele.source)) &&
          (_typeFilters.isEmpty || _typeFilters.contains(ele.type)) &&
          (_formatFilters.isEmpty || _formatFilters.contains(ele.format))),
    );
  }

  void clearFilters() {
    _scanFilters.clear();
    _formatFilters.clear();
    _typeFilters.clear();
    applyFilterAndLoad();
  }

  void removeFilter(Enum itemType) {
    setFilter(null, itemType, false);
    applyFilterAndLoad();
  }

  void setFilter(String? itemStr, Enum itemType, bool value) {
    if (itemType is QrSourceType) {
      value ? _scanFilters.add(itemType) : _scanFilters.remove(itemType);
    } else if (itemType is BarcodeType) {
      value ? _typeFilters.add(itemType) : _typeFilters.remove(itemType);
    } else if (itemType is BarcodeFormat) {
      value ? _formatFilters.add(itemType) : _formatFilters.remove(itemType);
    }
  }

  void setFilters(Map<String, Map<Enum, String>> groups, Set<Enum> items) {
    clearFilters();
    for (final item in items) {
      setFilter(null, item, true);
    }
    applyFilterAndLoad();
  }

  Future<void> loadData() async {
    if (await ScannerManager.instance.deleteExpiredSavedModels()) {
      NotificationManager.instance.notifiyDeleteExpired();
    }
    applyFilterAndLoad();
  }

  Future<void> deleteItem(QRCodeModel item) async {
    if (await ScannerManager.instance.deleteSavedQr(item)) {
      _items.value = List.from(_items.value)..remove(item);
      NotificationManager.instance.notifiyDeleted();
    }
  }

  void dispose() {
    ScannerManager.instance.removeListenerToSavedQr(loadData);
    _items.dispose();
    _searchTextController.dispose();
    _scanFilters.clear();
    _typeFilters.clear();
    _formatFilters.clear();
  }
}
