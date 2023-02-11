import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:developer' as developer;

import 'package:plant_it/constants.dart';

class NetworkHelper {
  static const String urlString = "https://d835-182-48-208-229.in.ngrok.io";


  static Future<Map> logInUser(String email, String password) async {
    var url = Uri.parse("$urlString/auth/login/");
    var body = jsonEncode({
      "email": email,
      "password": password,
    });
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      Map<String,dynamic> decoded = jsonDecode(response.body) as Map<String,dynamic>;
      for (var i in decoded.keys) {
        print(i + decoded[i].toString());
      }
      return decoded;
    } else {
      return {"message": "Error :("};
    }
  }

  static Future<Map<String,dynamic>> signUpUser(String name, String email, String password, UserType selectedUserType) async {
    var url = Uri.parse("$urlString/auth/signup/");
    var body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
      "user_type": selectedUserType.value,
    });
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      Map<String,dynamic> decoded = jsonDecode(response.body) as Map<String,dynamic>;
      return decoded;
    } else {
      return {"message": "Error :("};
    }
  }
}
