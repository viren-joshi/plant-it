import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const _userKey = "USER_KEY";
  static setUser(String user) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_userKey, user);
  }

  static getUser() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(_userKey) ?? "***";
  }

  static Future<bool> isLoggedIn() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.containsKey(_userKey);
  }

  static clearAll() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
  }
}