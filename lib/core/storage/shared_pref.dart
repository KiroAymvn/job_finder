import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final SharedPreferences prefs;

  SharedPref(this.prefs);

  // =======================
  // String
  // =======================

  Future<bool> setString({required String key, required String value}) {
    return prefs.setString(key, value);
  }

  String? getString({required String key}) {
    return prefs.getString(key);
  }

  // =======================
  // Bool
  // =======================

  Future<bool> setBool({required String key, required bool value}) {
    return prefs.setBool(key, value);
  }

  bool? getBool({required String key}) {
    return prefs.getBool(key);
  }

  // =======================
  // Int
  // =======================

  Future<bool> setInt({required String key, required int value}) {
    return prefs.setInt(key, value);
  }

  int? getInt({required String key}) {
    return prefs.getInt(key);
  }

  // =======================
  // Double
  // =======================

  Future<bool> setDouble({required String key, required double value}) {
    return prefs.setDouble(key, value);
  }

  double? getDouble({required String key}) {
    return prefs.getDouble(key);
  }

  // =======================
  // List<String>
  // =======================

  Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) {
    return prefs.setStringList(key, value);
  }

  List<String>? getStringList({required String key}) {
    return prefs.getStringList(key);
  }

  // =======================
  // Remove
  // =======================

  Future<bool> remove(String key) {
    return prefs.remove(key);
  }

  // =======================
  // Clear
  // =======================

  Future<bool> clear() {
    return prefs.clear();
  }

  // =======================
  // Contains
  // =======================

  bool contains(String key) {
    return prefs.containsKey(key);
  }
}
