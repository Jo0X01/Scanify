/// Typed exceptions for the location picker.
///
/// The service layer throws these; callers can catch specific subtypes
/// instead of branching on nullable returns.
library;

sealed class LocationPickerException implements Exception {
  const LocationPickerException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The device's location service (GPS / network) is turned off.
final class LocationServiceDisabledException extends LocationPickerException {
  const LocationServiceDisabledException()
    : super('Location service is disabled. Please enable it in Settings.');
}

/// The user denied location permission (or permanently denied it).
final class LocationPermissionDeniedException extends LocationPickerException {
  const LocationPermissionDeniedException()
    : super('Location permission was denied.');
}

/// Reverse- or forward-geocoding failed (network error, no results, etc.).
final class GeocodingException extends LocationPickerException {
  const GeocodingException([super.detail = 'Geocoding failed.']);
}
