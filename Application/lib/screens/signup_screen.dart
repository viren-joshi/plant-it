import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/model/user_model.dart';
import 'package:plant_it/screens/login_screen.dart';
import 'package:plant_it/services/network_helper.dart';
import 'package:plant_it/services/shared_prefs.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = "", email = "", password = "";
  bool isSpinning = false;

  UserType selectedUserType = UserType.none;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        dismissible: false,
        progressIndicator: kCircularProgressIndicator,
        inAsyncCall: isSpinning,
        child: Scaffold(
          backgroundColor: Colors.lightGreen.shade50,
          body: Center(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.green.shade400),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  margin: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Replace with image
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Plant It",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) => name = value,
                          decoration:
                              const InputDecoration(label: Text("Name")),
                          style: TextStyle(
                            color: Colors.green.shade400,
                          ),
                        ),
                      ),
                      // Email
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => email = value,
                          decoration:
                              const InputDecoration(label: Text("Email")),
                          style: TextStyle(
                            color: Colors.green.shade400,
                          ),
                        ),
                      ),
                      // Password
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) => password = value,
                          obscureText: true,
                          decoration:
                              const InputDecoration(label: Text("Password")),
                          style: TextStyle(
                            color: Colors.green.shade400,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<UserType>(
                              value: UserType.farmer,
                              groupValue: selectedUserType,
                              title: const Text(
                                "Farmer",
                                style: TextStyle(color: Colors.green),
                              ),
                              contentPadding: EdgeInsets.zero,
                              onChanged: (userType) => setState(() {
                                selectedUserType = userType ?? UserType.none;
                              }),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<UserType>(
                              value: UserType.enthusiast,
                              groupValue: selectedUserType,
                              title: const Text(
                                "Enthusiast",
                                style: TextStyle(color: Colors.green),
                              ),
                              contentPadding: EdgeInsets.zero,
                              onChanged: (userType) => setState(() {
                                selectedUserType = userType ?? UserType.none;
                              }),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (name == "" || email == "" || password == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent.shade200,
                                  content: const Text(
                                      "Name, Email and Password Fields are required."),
                                ),
                              );
                              return;
                            } else if (selectedUserType == UserType.none) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent.shade200,
                                  content: const Text(
                                      "Kindly select the user type."),
                                ),
                              );
                            }
                            setState(() {
                              isSpinning = true;
                            });
                            var response = await NetworkHelper.signUpUser(
                                name, email, password, selectedUserType);
                            if (response["status"]) {
                              var user = User(
                                  name: name,
                                  userType: selectedUserType,
                                  email: email,
                                  authToken: response["token"]);
                              await SharedPrefs.setUser(
                                  jsonEncode(user.toJson()));
                              setState(() {
                                isSpinning = false;
                              });
                              // TODO : Navigate to the Home Screen
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent.shade200,
                                  content: Text(
                                      "Sign Up Failed ${response["message"] ?? ""}"),
                                ),
                              );
                            }
                            setState(() {
                              isSpinning = false;
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text("Sign Up"),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            // Take user to Sign In Screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()));
                          },
                          child: const Text(
                              "Already have an account? Log In here"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
