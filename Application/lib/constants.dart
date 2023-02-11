import 'package:flutter/material.dart';

const kCircularProgressIndicator = CircularProgressIndicator(color: Colors.green,);

enum UserType {
  farmer("farmer"),
  enthusiast("enthusiast"),
  none("");

  const UserType(this.value);
  final String value;
}

UserType getUserType (String userType) {
  switch (userType) {
    case "farmer" :
      return UserType.farmer;
    case "enthusiast" :
      return UserType.enthusiast;
    default:
      return UserType.none;
  }
}