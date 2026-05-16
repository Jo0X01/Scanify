import 'package:hive/hive.dart';

class HistoryQRCodeModel extends HiveObject {
  final String? id;
  final String? data;
  final int? date;
  final String? type;
  bool isFavorite;

  HistoryQRCodeModel({
    this.id,
    this.data,
    this.date,
    this.type,
    this.isFavorite = false,
  });

  HistoryQRCodeModel copyWith({
    String? id,
    String? data,
    int? date,
    String? type,
    bool? isFavorite,
  }) {
    return HistoryQRCodeModel(
      id: id ?? this.id,
      data: data ?? this.data,
      date: date ?? this.date,
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() =>
      'HistoryQRCodeModel(id: $id, type: $type, date: $date, favorite: $isFavorite)';
}

class HistoryQRCodeModelAdapter extends TypeAdapter<HistoryQRCodeModel> {
  @override
  int get typeId => 0;

  @override
  HistoryQRCodeModel read(BinaryReader reader) {
    final fieldCount = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < fieldCount; i++) reader.readByte(): reader.read(),
    };

    return HistoryQRCodeModel(
      id: fields[0] as String?,
      data: fields[1] as String?,
      date: fields[2] as int?,
      type: fields[3] as String?,
      isFavorite: fields[4] as bool? ?? false
    );
  }

  @override
  void write(BinaryWriter writer, HistoryQRCodeModel obj) {
    writer.writeByte(5); 
    writer
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isFavorite);
  }
}
