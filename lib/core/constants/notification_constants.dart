abstract class NotificationChannels {
  NotificationChannels._();

  static const String camera = 'camera_channel';
  static const String history = 'history_channel';
  static const String save = 'save_channel';
}

abstract class NotificationIds {
  NotificationIds._();

  static const int camera = 1;
  static const int history = 2;
  static const int save = 3;
  static const int expired = 4;
  static const int delete = 5;
}

abstract class NotificationTitles {
  NotificationTitles._();

  static const String camera = 'Camera Status';
  static const String cameraDesc = 'Shows when camera is active';

  static const String history = 'History Changes';
  static const String historyDesc = 'Shows when clear local saved database';

  static const String save = 'Save Changes';
  static const String saveDesc = 'Shows when new qr added to local database';
}
