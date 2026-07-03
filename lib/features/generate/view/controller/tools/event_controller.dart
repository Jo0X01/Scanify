import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanify/core/constants/app_helpers.dart';
import 'package:scanify/core/services/settings_service.dart';
import 'package:scanify/core/enum/tool_data_types.dart' show PopularType;
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart'
    show PopularTemplateController;

class EventController implements PopularTemplateController {
  final _datePattern = "EEE, dd/MM/yyyy";
  late SettingsService _settingsService;
  late TextEditingController _eTitle;
  late TextEditingController _sDate;
  late TextEditingController _eDate;
  late TextEditingController _location;
  late TextEditingController _description;
  late DateTime? __sDate;
  late DateTime? __eDate;

  @override
  final String title;
  @override
  final String iconSvgPath;
  EventController({required this.title, required this.iconSvgPath});

  TextEditingController get titleController => _eTitle;
  TextEditingController get startDateController => _sDate;
  TextEditingController get endDateController => _eDate;
  TextEditingController get locationController => _location;
  TextEditingController get descController => _description;

  DateTime get currentSDate => __sDate ?? DateTime.now();
  DateTime get currentEDate => __eDate ?? DateTime.now();

  String get eTitle => _eTitle.text.trim();

  void onPickSDate(DateTime? val) {
    if (val == null) return;
    __sDate = val;
    _sDate.text = getReadableDate(val);
  }

  void onPickEDate(DateTime? val) {
    if (val == null) return;
    __eDate = val;
    _eDate.text = getReadableDate(val);
  }

  @override
  void init() {
    _settingsService = SettingsService.instance;
    __sDate = DateTime.now();
    __eDate = DateTime.now();
    _eTitle = TextEditingController();
    _sDate = TextEditingController();
    _eDate = TextEditingController();
    _location = TextEditingController();
    _description = TextEditingController();
    onPickSDate(__sDate);
    onPickEDate(__eDate);
  }

  @override
  BarcodeType get dataType => BarcodeType.calendarEvent;
  @override
  PopularType get gDataType => PopularType.event;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  @override
  String buildQrData() {
    final buffer = StringBuffer()
      ..writeln("BEGIN:VEVENT")
      ..writeln("SUMMARY:$eTitle")
      ..writeln("DTSTART:${_formatDate(__sDate!)}")
      ..writeln("DTEND:${_formatDate(__eDate!)}");
    if (_location.text.isNotEmpty) {
      buffer.writeln("LOCATION:${_location.text.trim()}");
    }
    if (_description.text.isNotEmpty) {
      buffer.writeln("DESCRIPTION:${_description.text.trim()}");
    }
    buffer.writeln("END:VEVENT");
    return buffer.toString();
  }

  @override
  void dispose() {
    _eTitle.dispose();
    _sDate.dispose();
    _eDate.dispose();
    _location.dispose();
    _description.dispose();
  }

  String _formatDate(DateTime dt) {
    final utc = dt.toUtc();
    return '${utc.year.toString().padLeft(4, '0')}'
        '${utc.month.toString().padLeft(2, '0')}'
        '${utc.day.toString().padLeft(2, '0')}T'
        '${utc.hour.toString().padLeft(2, '0')}'
        '${utc.minute.toString().padLeft(2, '0')}'
        '${utc.second.toString().padLeft(2, '0')}Z';
  }

  DateTime? getDateTimeValue(String? data) {
    if (data == null) return null;
    return AppHelpers.getMillisFromReadableDate(
      data,
      pattern: _datePattern,
      locale: _settingsService.language.languageCode,
    );
  }

  String getReadableDate(DateTime date) {
    return AppHelpers.getReadableDate(
      date.millisecondsSinceEpoch,
      locale: _settingsService.language.languageCode,
      pattern: _datePattern,
    );
  }
}
