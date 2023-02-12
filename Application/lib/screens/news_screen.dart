import 'package:flutter/material.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/services/network_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:developer' as developer;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
            " Latest News",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          future: NetworkHelper.getNews(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var newsObj = snapshot.data![index];
                    return GestureDetector(
                      onTap: () async {
                        developer.log("Tapped");
                        await launchUrl(Uri.parse(newsObj["url"]));
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
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      Image.network(newsObj["urlToImage"]).image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                newsObj["title"],
                                style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "- ${newsObj["author"] ?? ""}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.green.shade400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                newsObj["description"],
                                style: const TextStyle(fontSize: 18),
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
