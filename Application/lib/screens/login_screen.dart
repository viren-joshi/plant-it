import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/model/user_model.dart';
import 'package:plant_it/screens/home_screen.dart';
import 'package:plant_it/screens/signup_screen.dart';
import 'package:plant_it/services/network_helper.dart';
import 'package:plant_it/services/shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "", password = "";
  bool isSpinning = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isSpinning,
        progressIndicator: kCircularProgressIndicator,
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
                      // Email
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => email = value,
                          decoration: const InputDecoration(label: Text("Email")),
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
                          obscureText: true,
                          onChanged: (value) => password = value,
                          decoration:
                              const InputDecoration(label: Text("Password")),
                          style: TextStyle(
                            color: Colors.green.shade400,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (email == "" || password == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  backgroundColor: Colors.redAccent.shade200,
                                  content: const Text(
                                      "Error ! Email and Password Fields are required"),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              isSpinning = true;
                            });
                            var response = await NetworkHelper.logInUser(email, password);
                            for (var i in response.keys) {
                              print(i + response[i].toString());
                            }
                            if(response["status"]) {
                              var user = User.fromJson(response);
                              await SharedPrefs.setUser(jsonEncode(user.toJson()));
                              setState(() {
                                isSpinning = false;
                              });
                              // TODO : Navigate to Home Screen
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.redAccent.shade200,
                                  content: Text("LogIn Failed ${response["message"] ?? ""}"),
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
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          child: const Text("Plant In"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            // Take user to Sign Up Screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpScreen()));
                          },
                          child: const Text("Don't have an account? Sign Up here"),
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
