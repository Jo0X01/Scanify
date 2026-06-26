import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibration/vibration.dart';

abstract class DeviceUtil {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> vibration() async {
    Vibration.cancel();
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 40);
    }
  }

  static Future<void> playClickSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/click.wav'));
  }

  static Future<String?> pickFolderPath({String? dialogTitle}) async {
    final result = await FilePicker.getDirectoryPath(dialogTitle: dialogTitle);
    return result;
  }

  static Future<List<XFile>> pickImagesFromGal() async {
    return await ImagePicker().pickMultiImage();
  }

}
