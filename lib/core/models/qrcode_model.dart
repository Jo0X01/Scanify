
import 'package:hive/hive.dart';
import 'package:qrcode_scanner_app/core/constants/app_hive.dart';

class HistoryQRCodeModel {
  final String? id;
  final String? data;
  final int? date;
  final String? type;

  HistoryQRCodeModel({this.id,this.data,this.date, this.type});
}


class HistoryQRCodeModelAdapter extends TypeAdapter<HistoryQRCodeModel>{
  @override
  int get typeId => AppHive.qrcodesId;

  @override
  HistoryQRCodeModel read(BinaryReader reader) {
    final id = reader.read() as String;
    final data = reader.read() as String;
    final date = reader.read() as int;
    final type = reader.read() as String;
    return HistoryQRCodeModel(id: id, data: data, date: date,type: type);
  }


  @override
  void write(BinaryWriter writer, HistoryQRCodeModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.data)
      ..write(obj.date)
      ..write(obj.type);
  }
}