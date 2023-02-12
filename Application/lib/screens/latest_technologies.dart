import 'package:flutter/material.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/services/network_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestTechnologies extends StatefulWidget {
  const LatestTechnologies({Key? key}) : super(key: key);

  @override
  State<LatestTechnologies> createState() => _LatestTechnologiesState();
}

class _LatestTechnologiesState extends State<LatestTechnologies> {
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
            "Latest Technologies",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          future: NetworkHelper.getLatestTechnologies(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var video = snapshot.data![index];
                    return GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse(video["url"]));
                      },
                      child: Container(
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                  Image.network(video["img1"]).image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                video["title"],
                                style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
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
