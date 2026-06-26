enum QrAction {
  /// Open an external application using a URI
  open,

  /// Display content inside the app
  view,

  /// Copy content to clipboard
  copy,

  /// Share content with other apps
  share,

  /// Save a contact to the device
  saveContact,

  /// Add an event to the calendar
  addCalendarEvent,

  /// Connect to or display Wi-Fi network details
  connectWifi,

  /// Open a location in a maps application
  openLocation,

  /// Search a product using a barcode value
  searchProduct,
}
