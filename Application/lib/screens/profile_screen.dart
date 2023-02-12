import 'package:flutter/material.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/services/shared_prefs.dart';

import 'dart:developer' as developer;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.green,
            size: 30,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "My Profile",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
            future: SharedPrefs.getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                developer.log("HERE");
                var user = snapshot.data!;
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Colors.lightGreen, width: 0.8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CircleAvatar(
                          minRadius: 50,
                          child:  Icon(Icons.person, size: 50,),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          user.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user.email.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user.userType.value.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: kCircularProgressIndicator,
                );
              }
            }),
      ),
    );
  }
}
