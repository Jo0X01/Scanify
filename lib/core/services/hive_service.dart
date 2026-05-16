import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  const HiveService._();

  static const String _boxName =
      '102c2b93bfe65a2f45cda4af7288767428e120b9222d866539bddb5183b498a8';
  static bool _initialized = false;

  static Future<void> init({List<TypeAdapter>? adapters}) async {
    if (_initialized) return;

    try {
      await Hive.initFlutter();
      if (adapters != null) {
        for (final adapter in adapters) {
          if (!Hive.isAdapterRegistered(adapter.typeId)) {
            Hive.registerAdapter(adapter);
          }
        }
      }
      if (!Hive.isBoxOpen(_boxName)) {
        await Hive.openBox(_boxName);
      }
      _initialized = true;
      debugPrint('LocalDB initialized successfully');
    } catch (e, stackTrace) {
      debugPrint('LocalDB initialization failed: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  static Box get _box {
    if (!_initialized) {
      throw StateError(
        'HiveService is not initialized. Call HiveService.init() first.',
      );
    }
    return Hive.box(_boxName);
  }

  static ValueListenable<Box> get listenable => _box.listenable();
  static Future<void> put<T>(String key, T value) async {
    if (!_box.containsKey(key)) {
      await _box.put(key, value);
    }
  }

  static T? get<T>(String key) {
    return _box.get(key) as T?;
  }

  static List<T> getAll<T>() {
    return _box.values.whereType<T>().toList();
  }

  static Future<bool> delete(String key) async {
    if (_box.containsKey(key)) {
      await _box.delete(key);
      return true;
    }

    return false;
  }

  static Future<void> deleteMany(List<String> keys) async {
    await _box.deleteAll(keys);
  }

  static Future<void> clear() async {
    await _box.clear();
  }

  static bool contains(String key) {
    return _box.containsKey(key);
  }

  static Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }
}
