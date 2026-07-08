import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManeger {
  static final PreferencesManeger _instance = PreferencesManeger._internal();

  factory PreferencesManeger() {
    return _instance;
  }

  PreferencesManeger._internal();
  late final SharedPreferences _preferences;
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //  Get Data
  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  //  Set Data

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  // Clear Data

  remove(String key) async {
    await _preferences.remove(key);
  }

  clear() async {
    await _preferences.clear();
  }
}
