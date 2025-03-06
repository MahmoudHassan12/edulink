import 'package:shared_preferences/shared_preferences.dart';

// mixin SharedPrefHelper {
//   static const String _isLoggedInKey = 'isLoggedIn';
//   static late SharedPreferences _instance;
//   static Future<SharedPreferences> init() async =>
//       _instance = await SharedPreferences.getInstance();

//   /// Saves the login status
//   static Future<void> setLoggedIn({bool isLoggedIn = false}) =>
//       _instance.setBool(_isLoggedInKey, isLoggedIn);

//   /// Retrieves the login status
//   static bool isLoggedIn() =>
//       _instance.getBool(_isLoggedInKey) ?? false; // Default: false

//   /// Clears login data (used on logout)
//   static Future<void> clearSession() => _instance.remove(_isLoggedInKey);
// }

mixin SharedPrefSingleton {
  static late SharedPreferences _instance;
  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();
  static Future<bool> setString(String key, String value) async =>
      _instance.setString(key, value);
  static String getString(String key) => _instance.getString(key) ?? '';
  static Future<bool> remove(String key) async => _instance.remove(key);
}
