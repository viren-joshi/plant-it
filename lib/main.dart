import 'package:flutter/material.dart';
import 'package:plant_it/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant It',
      theme: ThemeData(
          primarySwatch: Colors.green,

          inputDecorationTheme:  InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.green.shade300,
              letterSpacing: 1,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade100),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.green,
            selectionColor: Colors.lightGreen.shade200,
            selectionHandleColor: Colors.green,
          )),
      home: const LoginScreen(),
    );
  }
}
