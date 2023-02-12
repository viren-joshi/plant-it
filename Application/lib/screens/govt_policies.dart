import 'package:flutter/material.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/services/network_helper.dart';

import 'dart:developer' as developer;

class GovtPolicies extends StatefulWidget {
  const GovtPolicies({Key? key}) : super(key: key);

  @override
  State<GovtPolicies> createState() => _GovtPoliciesState();
}

class _GovtPoliciesState extends State<GovtPolicies> {
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
            "Latest Govt. Policies",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          future: NetworkHelper.getGovtPolicies(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var scheme = snapshot.data![index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              scheme["name"],
                              style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              scheme["description"],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: kCircularProgressIndicator,
              );
            }
          },
        ),
      ),
    );
  }
}
