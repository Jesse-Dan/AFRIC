import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  StorageUtil._privateConstructor();
  static final StorageUtil instance = StorageUtil._privateConstructor();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> save<T>(String key, T value) async {
    if (_prefs == null) await init();

    if (value is String) return _prefs!.setString(key, value);
    if (value is int) return _prefs!.setInt(key, value);
    if (value is bool) return _prefs!.setBool(key, value);
    if (value is double) return _prefs!.setDouble(key, value);
    if (value is List<String>) return _prefs!.setStringList(key, value);

    throw Exception('Unsupported type');
  }

  Future<T?> get<T>(String key) async {
    if (_prefs == null) await init();

    final value = _prefs!.get(key);
    if (value is T) return value;
    return null;
  }

  Future<bool> remove(String key) async {
    if (_prefs == null) await init();
    return _prefs!.remove(key);
  }

  Future<bool> clear() async {
    if (_prefs == null) await init();
    return _prefs!.clear();
  }

  Future<bool> update<T>(String key, T value) async {
    return save<T>(key, value);
  }
}
