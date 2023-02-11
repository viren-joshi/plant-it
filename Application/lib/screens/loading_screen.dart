import 'package:flutter/material.dart';
import 'package:plant_it/screens/home_screen.dart';
import 'package:plant_it/screens/signup_screen.dart';
import 'package:plant_it/services/shared_prefs.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Future<bool> isLoggedIn() async {
    bool val = await SharedPrefs.isLoggedIn();
    await Future.delayed(const Duration(seconds: 3));
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade100,
        body: FutureBuilder<bool>(
            future: isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                });

                return const SizedBox.shrink();
              } else if (snapshot.data == false) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignUpScreen(),
                    ),
                  );
                });

                return const SizedBox.shrink();
              }
              return Center(
                child: CircleAvatar(
                    backgroundImage: Image.asset("images/logo.png",scale: 0.8,).image,
                  radius: 60,
                    ),
              );
            }),
      ),
    );
  }
}
