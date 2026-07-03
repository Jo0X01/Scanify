import 'package:hive/hive.dart';
import 'package:scanify/core/constants/app_helpers.dart' show AppHelpers;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanify/core/enum/qr_source_type.dart';

class QRCodeModel extends HiveObject {
  final String? id;
  final String? data;
  final String? typeStr;
  final String? formatStr;
  final int? date;
  final QrSourceType? source;
  final BarcodeFormat? format;
  final BarcodeType? type;
  bool isFavorite;

  QRCodeModel({
    this.id,
    this.data,
    this.date,
    this.typeStr,
    this.formatStr,
    this.isFavorite = false,
    this.source,
    this.format,
    this.type,
  });

  factory QRCodeModel.fromData(
    String? raw, {
    required BarcodeType type,
    required BarcodeFormat format,
    QrSourceType source = QrSourceType.scan,
  }) {
    return QRCodeModel(
      id: raw != null ? AppHelpers.generateMd5(raw) : null,
      data: raw,
      date: DateTime.now().millisecondsSinceEpoch,
      type: type,
      typeStr: type.name,
      format: format,
      formatStr: format.name,
      source: source,
    );
  }

  factory QRCodeModel.fromBarcode(
    Barcode code, [
    QrSourceType source = QrSourceType.scan,
  ]) {
    final raw = code.rawValue;
    return QRCodeModel(
      id: raw != null ? AppHelpers.generateMd5(raw) : null,
      data: raw,
      date: DateTime.now().millisecondsSinceEpoch,
      type: code.type,
      typeStr: code.type.name,
      format: code.format,
      formatStr: code.format.name,
      source: source,
    );
  }

  static Set<QRCodeModel> fromBarcodes(
    Set<Barcode> codes,
    QrSourceType source,
  ) => codes.map((c) => QRCodeModel.fromBarcode(c, source)).toSet();

  QRCodeModel copyWith({
    String? id,
    String? data,
    int? date,
    String? typeStr,
    String? formatStr,
    bool? isFavorite,
    QrSourceType? source,
    BarcodeFormat? format,
    BarcodeType? type,
  }) => QRCodeModel(
    id: id ?? this.id,
    data: data ?? this.data,
    date: date ?? this.date,
    typeStr: typeStr ?? this.typeStr,
    formatStr: formatStr ?? this.formatStr,
    isFavorite: isFavorite ?? this.isFavorite,
    source: source ?? this.source,
    format: format ?? this.format,
    type: type ?? this.type,
  );

  @override
  String toString() =>
      'QRCodeModel('
      'id: $id, '
      'type: $type, '
      'format: $format, '
      'source: $source, '
      'date: $date, '
      ')';
}
