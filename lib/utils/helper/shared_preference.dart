import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferenceKey{
  keyDarkTheme,
  keyUserName,
  keyUserEmail,
}

class PreferencesService {
  static late SharedPreferences _sharedPreferences;

  static Future setUpSharedInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> putDouble(SharedPreferenceKey key, String value) =>
      _sharedPreferences.setString(key.name, value);

  double? getDouble(SharedPreferenceKey key) =>
      _sharedPreferences.getDouble(key.name);

  Future<bool> putInt(SharedPreferenceKey key, int value) =>
      _sharedPreferences.setInt(key.name, value);

  int? getInt(SharedPreferenceKey key) => _sharedPreferences!.getInt(key.name);

  Future<bool> putBool(SharedPreferenceKey key, bool value) =>
      _sharedPreferences.setBool(key.name, value);

  bool? getBool(SharedPreferenceKey key) =>
      _sharedPreferences.getBool(key.name);

  Future<bool> putString(SharedPreferenceKey key, String value) =>
      _sharedPreferences.setString(key.name, value);

  String? getString(SharedPreferenceKey key) =>
      _sharedPreferences.getString(key.name);

  Future<bool> putStringList(SharedPreferenceKey key, List<String> value) =>
      _sharedPreferences.setStringList(key.name, value);

  List<String> getStringList(SharedPreferenceKey key) =>
      _sharedPreferences.getStringList(key.name) ?? [];

  Future<void> removeByKey(SharedPreferenceKey key) =>
      _sharedPreferences.remove(key.name);

}