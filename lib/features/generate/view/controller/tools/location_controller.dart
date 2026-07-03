import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:scanify/core/enum/tool_data_types.dart' show PopularType;
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart';
import 'package:scanify/shared/location_picker/location_picker.dart';

enum LocationRequestState { permission, service, done, unknown }

class LocationController implements PopularTemplateController {
  late TextEditingController latController;
  late TextEditingController longController;
  late TextEditingController currentAddress;
  late ValueNotifier<LatLng?> posListener;
  late LocationPickerResult result;
  late LocationPickerService _locationService;
  LatLng? get currentPos => posListener.value;
  String get currentAddressText => currentAddress.text;

  @override
  final String title;
  @override
  final String iconSvgPath;

  LocationController({required this.title, required this.iconSvgPath});

  Future<LocationRequestState> loadCurrentLocation() async {
    try {
      final location = await _locationService.getCurrentLocation();
      latController.text = location.latitude.toString();
      longController.text = location.longitude.toString();
      result = result.copyWith(location: location);
      final address = await _locationService.getAddressFromLocation(location);
      if (address != null) {
        currentAddress.text = address;
        result = result.copyWith(address: address);
      }
      return LocationRequestState.done;
    } on (LocationServiceDisabledException,GeocodingException) {
      return LocationRequestState.service;
    } on LocationPermissionDeniedException {
      return LocationRequestState.permission;
    }
  }

  void setCord(LocationPickerResult value) {
    if (!value.isLocationEmpty) {
      posListener.value = value.location;
      latController.text = value.location!.latitude.toString();
      longController.text = value.location!.longitude.toString();
      result = result.copyWith(location: value.location);
    }
    if (!value.isAddressEmpty) {
      currentAddress.text = value.address ?? "";
      result = result.copyWith(address: value.address);
    }
  }

  void onChange(String value) {
    final lt = double.tryParse(latController.text);
    final lg = double.tryParse(longController.text);
    if (lt == null || lg == null) return;
    if (lt == result.latitude && lg == result.longitude) {
      return;
    }
    result = result.copyWith(
      location: LatLng(lt, lg),
      address: null,
      placemark: null,
    );
  }

  void updateCords() {
    final lt = double.tryParse(latController.text);
    final lg = double.tryParse(longController.text);
    if (lt == null || lg == null) {
      return;
    }
    result = result.copyWith(
      location: LatLng(lt, lg),
      address: null,
      placemark: null,
    );
    posListener.value = result.location;
    latController.text = result.latitude.toString();
    longController.text = result.longitude.toString();
    currentAddress.clear();
  }

  void clearData() {
    latController.clear();
    longController.clear();
    currentAddress.clear();
    updateCords();
  }

  @override
  String buildQrData() {
    return "geo:${latController.text},${longController.text}";
  }

  @override
  BarcodeType get dataType => BarcodeType.geo;
  @override
  PopularType get gDataType => PopularType.location;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  @override
  void dispose() {
    latController.dispose();
    longController.dispose();
    currentAddress.dispose();
    posListener.dispose();
  }

  @override
  void init() async {
    _locationService = LocationPickerService();
    posListener = ValueNotifier(null);
    latController = TextEditingController();
    longController = TextEditingController();
    currentAddress = TextEditingController();
    result = LocationPickerResult();
  }
}
