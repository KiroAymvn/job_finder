import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final String isLogged = "isLogged";

  Future<void> setDataBool({required String key, required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getDataBool({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
