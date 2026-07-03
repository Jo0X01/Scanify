import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanify/core/enum/tool_data_types.dart' show PopularType;
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart';

enum WifiProtection {
  nopass("nopass"),
  wep("WEP"),
  wpa("WPA/WPA2"),
  wpa3("WPA3");

  final String label;
  const WifiProtection(this.label);
}

class WifiController implements PopularTemplateController {
  late TextEditingController _ssid;
  late TextEditingController _password;
  late ValueNotifier<bool> _isHidden;
  late ValueNotifier<WifiProtection> _security;

  void setHidden(bool? value) => _isHidden.value = value ?? false;
  void setSecurity(WifiProtection? value) =>
      _security.value = value ?? WifiProtection.nopass;

  @override
  final String title;
  @override
  final String iconSvgPath;
  WifiController({required this.title, required this.iconSvgPath});

  TextEditingController get ssidController => _ssid;
  TextEditingController get passwordController => _password;
  ValueNotifier<bool> get isHiddenListener => _isHidden;
  ValueNotifier<WifiProtection> get securityListener => _security;

  bool get isHidden => _isHidden.value;
  String get ssid => _ssid.text.trim();
  String get password => _password.text.trim();
  WifiProtection get security => _security.value;

  @override
  void init() {
    _ssid = TextEditingController();
    _password = TextEditingController();
    _isHidden = ValueNotifier(false);
    _security = ValueNotifier(WifiProtection.nopass);
  }

  @override
  BarcodeType get dataType => BarcodeType.wifi;
  @override
  PopularType get gDataType => PopularType.wifi;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  @override
  String buildQrData() {
    if (WifiProtection.nopass == _security.value) {
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
