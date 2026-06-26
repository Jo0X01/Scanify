import 'package:geocoding/geocoding.dart' show Placemark;
import 'package:latlong2/latlong.dart' show LatLng;

/// Immutable value object that carries the result of a location pick.
///
/// All three fields are nullable — the object may be "empty" when no location
/// has been selected yet (see [isLocationEmpty]).
class LocationPickerResult {
  const LocationPickerResult({this.location, this.address, this.placemark});

  /// The raw geographic coordinate.
  final LatLng? location;

  /// Human-readable address produced by reverse geocoding [location].
  final String? address;

  /// Detailed placemark data (street, city, country, …) for [location].
  final Placemark? placemark;

  // ---------------------------------------------------------------------------
  // Convenience accessors
  // ---------------------------------------------------------------------------

  double? get latitude => location?.latitude;
  double? get longitude => location?.longitude;

  bool get isLocationEmpty => location == null;
  bool get isAddressEmpty => address == null || address!.isEmpty;
  bool get isPlacemarkEmpty => placemark == null;

  // ---------------------------------------------------------------------------
  // copyWith
  // ---------------------------------------------------------------------------

  /// Returns a new instance with the supplied fields replaced.
  ///
  /// Pass [clearAddress] / [clearPlacemark] as `true` to explicitly null out
  /// those fields (since `copyWith` cannot distinguish "omitted" from "null").
  LocationPickerResult copyWith({
    LatLng? location,
    String? address,
    Placemark? placemark,
    bool clearAddress = false,
    bool clearPlacemark = false,
  }) {
    return LocationPickerResult(
      location: location ?? this.location,
      address: clearAddress ? null : (address ?? this.address),
      placemark: clearPlacemark ? null : (placemark ?? this.placemark),
    );
  }

  // ---------------------------------------------------------------------------
  // Object overrides
  // ---------------------------------------------------------------------------

  @override
  bool operator ==(Object other) =>
      other is LocationPickerResult &&
      other.location?.latitude == location?.latitude &&
      other.location?.longitude == location?.longitude &&
      other.address == address;

  @override
  int get hashCode =>
      Object.hash(location?.latitude, location?.longitude, address);

  @override
  String toString() =>
      'LocationPickerResult(location: $location, address: $address, '
      'placemark: $placemark)';
}
