import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPrefSingleton {
  static late SharedPreferences _instance;
  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static Future<void> reload() => _instance.reload();

  /// Setters
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);
  static Future<bool> setStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);

  static Future<bool> setBool(String key, {required bool value}) =>
      _instance.setBool(key, value);

  static Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  /// Getters
  static String getString(String key) => _instance.getString(key) ?? '';
  static int getInt(String key) => _instance.getInt(key) ?? 0;
  static List<String>? getStringList(String key) =>
      _instance.getStringList(key);

  static bool getBool(String key) => _instance.getBool(key) ?? false;

  /// Removers
  static Future<bool> remove(String key) => _instance.remove(key);
  static Future<bool> clear() => _instance.clear();
}
