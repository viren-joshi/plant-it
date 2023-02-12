import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:developer' as developer;

import 'package:plant_it/constants.dart';

class NetworkHelper {
  static const String urlString = "http://139.59.88.171:8010";

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
      Map<String, dynamic> decoded =
          jsonDecode(response.body) as Map<String, dynamic>;
      return decoded;
    } else {
      return {"message": "Error :("};
    }
  }

  static Future<Map<String, dynamic>> signUpUser(String name, String email,
      String password, UserType selectedUserType) async {
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
      Map<String, dynamic> decoded =
          jsonDecode(response.body) as Map<String, dynamic>;
      return decoded;
    } else {
      return {"message": "Error :("};
    }
  }

  static Future<List> getNews() async {
    var url = Uri.parse("$urlString/news/");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      List decoded = jsonDecode(response.body);

      return decoded;
    } else {
      return [
        {"message": "Error :("}
      ];
    }
  }

  static Future<Map<String, dynamic>> getPlantInfo(
      double longitude, double latitude) async {
    var url = Uri.parse("$urlString/recommend/?lat=$latitude&lon=$longitude");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded =
          jsonDecode(response.body) as Map<String, dynamic>;
      return decoded;
    } else {
      return {"message": "Error :("};
    }
  }

  static Future<List> getGovtPolicies() async {
    var url = Uri.parse("$urlString/schemes/");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      List decoded = jsonDecode(response.body);
      return decoded;
    } else {
      return [
        {"message": "Error :("}
      ];
    }
  }

  static Future<List> getLatestTechnologies() async {
    var url = Uri.parse("$urlString/latest/");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      List decoded = jsonDecode(response.body);
      return decoded;
    } else {
      return [
        {"message": "Error :("}
      ];
    }
  }

  static Future<List> getPosts(String email) async {
    var url = Uri.parse("$urlString/feed/?username=$email}");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      List decoded = jsonDecode(response.body);
      return decoded;
    } else {
      return [
        {"message": "Error :("}
      ];
    }
  }

  static Future likePost(String email, int postId) async {
    var url = Uri.parse("$urlString/like/?username=$email&post_id=$postId");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      developer.log("Success");
    } else {
      developer.log("Failure");
    }
  }

  static Future addComment(String comment, int postId, String op) async {
    var url = Uri.parse("$urlString/comments/");
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "comment": comment,
          "post_id": postId,
          "author": op,
        }));
    developer.log(response.body);
    if (response.statusCode == 200) {
      developer.log("Success");
    } else {
      developer.log("Failure");
    }
  }

  static Future makeAPost(
      String caption, XFile image, String name, UserType userType) async {
    var url = Uri.parse("$urlString/upload/");
    var request = http.MultipartRequest("POST", url);
    request.files.add(
      await http.MultipartFile.fromPath("image", image.path,
          filename: image.name),
    );
    request.headers.addAll({
      "Content-Type": "application/json",
    });
    var response = await request.send();
    String s = await response.stream.bytesToString();
    developer.log(s);
    var imageDecode = jsonDecode(s);
    var urlPost = Uri.parse("$urlString/feed/");
    var postResponse = await http.post(urlPost,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "caption": caption,
          "image": "${imageDecode["slug"]}",
          "user_type": userType.value,
          "author": name
        }));
    developer.log(postResponse.body);
    if (postResponse.statusCode == 200) {
      developer.log("Success");
    } else {
      developer.log("Failure");
    }
  }

  static Future<List> getUserChatList() async {
    var url = Uri.parse("$urlString/userlist");
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    developer.log(response.body);
    if(response.statusCode == 200){
      List decoded = jsonDecode(response.body);
      return decoded;
    } else {
      return ["Error :("];
    }
  }
}
