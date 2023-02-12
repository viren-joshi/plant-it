import 'package:flutter/material.dart';
import 'package:plant_it/screens/govt_policies.dart';
import 'package:plant_it/screens/latest_technologies.dart';
import 'package:plant_it/screens/news_screen.dart';
import 'package:plant_it/screens/plant_now_screen.dart';
import 'package:plant_it/screens/profile_screen.dart';
import 'package:plant_it/screens/signup_screen.dart';
import 'package:plant_it/services/shared_prefs.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: Image.asset(
                  "images/plant_bg.jpg",
                ).image,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.modulate),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: const Text("My Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.gps_fixed_rounded,
              color: Colors.green,
            ),
            title: const Text("Plant Now!"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlantNowScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.newspaper,
              color: Colors.green,
            ),
            title: const Text("Latest News!"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NewsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_balance_outlined,
              color: Colors.green,
            ),
            title: const Text("Govt. Policies"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GovtPolicies(),
                ),
              );
            },
          ),
          // Farming Technology
          ListTile(
            leading: const Icon(
              Icons.rocket_launch_outlined,
              color: Colors.green,
            ),
            title: const Text("Latest Technologies"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LatestTechnologies(),
                ),
              );
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              await SharedPrefs.clearAll();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
            },
          ),
        ],
      ),
    );
  }
}
