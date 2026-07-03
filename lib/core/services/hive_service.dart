import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();
  static final instance = HiveService._();

  late final String _boxName;
  bool _initialized = false;

  Future<void> init({String? boxName, List<TypeAdapter>? adapters}) async {
    if (_initialized) return;
    _boxName =
        boxName ??
        '102c2b93bfe65a2f45cda4af7288767428e120b9222d866539bddb5183b498a8';

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
        await Hive.openBox<dynamic>(_boxName);
      }

      _initialized = true;
    } catch (e) {
      try {
        await Hive.deleteBoxFromDisk(_boxName);
        await Hive.openBox<dynamic>(_boxName);
        _initialized = true;
      } catch (e2) {
        rethrow;
      }
    }
  }

  Box get _box {
    if (!_initialized) {
      throw StateError(
        'HiveService is not initialized. Call HiveService.init() first.',
      );
    }
    return Hive.box(_boxName);
  }

  ValueListenable<Box> get listenable => _box.listenable();

  Future<void> putAll<T>(Map<String, T> entries) async {
    await _box.putAll(entries);
  }

  Future<void> put<T>(String? key, T? value) async {
    if (value == null || key == null) return;
    await _box.put(key, value);
  }

  Future<bool> putIfAbsent<T>(String? key, T? value) async {
    if (value == null || key == null) return false;
    if (!_box.containsKey(key)) {
      await _box.put(key, value);
      return true;
    }
    return false;
  }

  T? get<T>(String key) {
    return _box.get(key) as T?;
  }

  List<T> getAll<T>([bool Function(T)? callback]) {
    final result = _box.values.whereType<T>();
    if (callback != null) {
      return result.where(callback).toList();
    }
    return result.toList();
  }

  Future<bool> delete(String? key) async {
    if (key == null) return false;
    if (_box.containsKey(key)) {
      await _box.delete(key);
      return true;
    }
    return false;
  }

  Future<void> deleteMany(List<String> keys) async {
    await _box.deleteAll(keys);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  bool contains(String key) {
    return _box.containsKey(key);
  }

  Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }
}
