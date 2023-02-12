import 'package:plant_it/constants.dart';

class User {
  String name;
  String email;
  UserType userType;
  String authToken;

  User({required this.name, required this.userType, required this.authToken, required this.email});

  factory User.fromJson(Map map){
    return User(
      name: map["name"],
      userType: getUserType(map["user_type"]),
      email: map["email"],
      authToken: map["token"],
    );
  }

   Map toJson() {
    Map user = {};
    user.addAll({"name" : name});
    user.addAll({"email" : email});
    user.addAll({"user_type" : userType.value});
    user.addAll({"token" : authToken});
    return user;
  }

}