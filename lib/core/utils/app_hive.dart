import 'package:hive/hive.dart';
import 'package:qrcode_scanner_app/core/constants/app_hive.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';

abstract class AppHiveUtils {
  static Future<Box<HistoryQRCodeModel>> get _getBox async => await Hive.openBox<HistoryQRCodeModel>(AppHive.qrcodesBox);
  
  static Future<void> addQRCode(HistoryQRCodeModel model) async {
    final box = await _getBox;
    if(!box.containsKey(model.id)){
      await box.put(model.id, model);
    }
  }

  static Future<bool> removeQRCode(String? id) async {
    final box = await _getBox;
    if(box.containsKey(id)){
      await box.delete(id);
      return true;
    }
    return false;
  }
  static Future<List<HistoryQRCodeModel>> getStoredQRs() async {
    final box = await _getBox;
    final list = box.values.toList()..sort((a, b) => b.date!.compareTo(a.date!));
    return list;
  }
}