import 'dart:io' show File, Directory;

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';
import 'package:image/image.dart' as img;

abstract class DeviceUtil {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> vibration() async {
    Vibration.cancel();
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(duration: 40);
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

  static Future<List<String>> pickImagesFromGal() async {
    final files = await ImagePicker().pickMultiImage(
      requestFullMetadata: false,
    );
    if (files.isEmpty) return [];
    return files.map((ele) => ele.path).toList();
  }

  static Future<String> ensureJpegForAnalysis(String path) async {
    final lower = path.toLowerCase();
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return path;

    try {
      final tempDir = await getTemporaryDirectory();
      final dir = Directory(tempDir.path);
      if (await dir.exists()) {
        final now = DateTime.now();
        await for (final entity in dir.list()) {
          if (entity is File &&
              entity.path.contains('scanify_pick_') &&
              entity.path.endsWith('.jpg')) {
            final stat = await entity.stat();
            if (now.difference(stat.modified).inHours >= 1) {
              await entity.delete();
            }
          }
        }
      }
      final bytes = await File(path).readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return path;

      final jpegBytes = img.encodeJpg(decoded, quality: 92);

      final tempPath =
          '${tempDir.path}/scanify_pick_${DateTime.now().microsecondsSinceEpoch}.jpg';
      await File(tempPath).writeAsBytes(jpegBytes);
      return tempPath;
    } catch (_) {
      return path;
    }
  }
}
