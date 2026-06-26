



import 'package:hive/hive.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/enum/qr_error_correction.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';

class QRCodeModelAdapter extends TypeAdapter<QRCodeModel> {
  @override
  int get typeId => 0;

  @override
  QRCodeModel read(BinaryReader reader) {
    final fieldCount = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < fieldCount; i++) reader.readByte(): reader.read(),
    };

    return QRCodeModel(
      id: fields[0] as String?,
      data: fields[1] as String?,
      date: fields[2] as int?,
      typeStr: fields[3] as String?,
      formatStr: fields[4] as String?,
      isFavorite: fields[5] as bool? ?? false,
      source: fields[6] != null
          ? QrSourceType.values.byName(fields[6] as String)
          : null,
      format: fields[7] != null
          ? BarcodeFormat.values.byName(fields[7] as String)
          : null,
      type: fields[8] != null
          ? BarcodeType.values.byName(fields[8] as String)
          : null,
      eccLevel: fields[9] as QrErrorCorrectionLevel?,
    );
  }

  @override
  void write(BinaryWriter writer, QRCodeModel obj) {
    final fields = [
      obj.id,
      obj.data,
      obj.date,
      obj.typeStr,
      obj.formatStr,
      obj.isFavorite,
      obj.source?.name,
      obj.format?.name,
      obj.type?.name,
      obj.eccLevel,
    ];

    writer.writeByte(fields.length);
    fields.asMap().forEach((key, value) {
      writer
        ..writeByte(key)
        ..write(value);
    });
  }
}
