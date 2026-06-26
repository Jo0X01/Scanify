import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart';

class WifiController implements PopularTemplateController {
  final List<String> _wifiSecurityList = ["None", "WEP", "WPA/WPA2", "WPA3"];

  late TextEditingController _ssid;
  late TextEditingController _password;
  late ValueNotifier<bool> _isHidden;
  late ValueNotifier<String> _security;

  void setHidden(bool? value) => _isHidden.value = value ?? false;
  void setSecurity(String? value) =>
      _security.value = value ?? _wifiSecurityList.first;

  @override
  final String title;
  @override
  final String iconSvgPath;
  WifiController({required this.title, required this.iconSvgPath});

  List<String> get avaliableSecurityList => _wifiSecurityList;
  TextEditingController get ssidController => _ssid;
  TextEditingController get passwordController => _password;
  ValueNotifier<bool> get isHiddenListener => _isHidden;
  ValueNotifier<String> get securityListener => _security;

  bool get isHidden => _isHidden.value;
  String get ssid => _ssid.text.trim();
  String get password => _password.text.trim();
  String get security => _security.value.trim();

  @override
  void init() {
    _ssid = TextEditingController();
    _password = TextEditingController();
    _isHidden = ValueNotifier(false);
    _security = ValueNotifier(_wifiSecurityList.first);
  }

  @override
  BarcodeType get dataType => BarcodeType.wifi;
  @override
  PopularType get gDataType => PopularType.wifi;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  @override
  String buildQrData() {
    if (security == _wifiSecurityList.first) {
      return 'WIFI:S:$ssid;H:$isHidden;;';
    }
    return 'WIFI:S:$ssid;'
        'T:$security;'
        'P:$password;'
        'H:$isHidden;;';
  }

  @override
  void dispose() {
    _ssid.dispose();
    _password.dispose();
    _isHidden.dispose();
    _security.dispose();
  }
}
