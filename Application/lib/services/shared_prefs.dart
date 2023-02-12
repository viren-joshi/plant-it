import 'dart:convert';
import 'dart:developer' as developer;

import 'package:plant_it/constants.dart';
import 'package:plant_it/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const _userKey = "USER_KEY";
  static setUser(String user) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_userKey, user);
  }

  static Future<User> getUser() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    String? userData = sharedPrefs.getString(_userKey);
    developer.log(userData ?? "NULL");
    User user;
    if(userData == null) {
      user = User(name: "NULL", userType:UserType.farmer, authToken:"null", email:"null");
    } else {
      user = User.fromJson(jsonDecode(userData));
    }
    developer.log(user.email);
    return user;
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