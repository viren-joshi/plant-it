import 'package:flutter/material.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/services/location_helper.dart';

import 'dart:developer' as developer;

import 'package:plant_it/services/network_helper.dart';

class PlantNowScreen extends StatefulWidget {
  const PlantNowScreen({Key? key}) : super(key: key);

  @override
  State<PlantNowScreen> createState() => _PlantNowScreenState();
}

class _PlantNowScreenState extends State<PlantNowScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<Map<String, dynamic>> onGetLocationPressed() async {
    var location = LocationHelper();
    await location.getCurrentLocation();
    var response =
        await NetworkHelper.getPlantInfo(location.longitude, location.latitude);

    return response;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

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
            "Plant Now",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          future: onGetLocationPressed(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var response = snapshot.data!;
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 30,
                    ),
                    title: Text(response["location"]),
                  ),
                  ClimateInfoWidget(climate: response["climate"]),
                  DefaultTabController(
                    length: 2,
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          icon: Text(
                            "Crops",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Tab(
                          icon: Text(
                            "Plants",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.separated(
                          itemBuilder: (context, index) {
                            var crop = response["crops"][index];
                            return CropInfoListTile(crop: crop);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.lightGreen.shade100,
                              thickness: 1.5,
                              height: 3,
                            );
                          },
                          itemCount: response["crops"].length,
                        ),
                        ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 10.0,
                          ),
                          children: [
                            Text(
                              "Sow-Indoors",
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              child: Text(
                                response["plants"]["sow_indoors"],
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Sow-Outdoors",
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              child: Text(
                                response["plants"]["sow_outdoors"],
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Harvest",
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              child: Text(
                                response["plants"]["harvest"],
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
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

class CropInfoListTile extends StatelessWidget {
  const CropInfoListTile({
    super.key,
    required this.crop,
  });

  final Map<String, dynamic> crop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              crop["name"],
              style: TextStyle(
                color: Colors.green.shade600,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListTile(
              dense: true,
              leading: const Icon(
                Icons.grain,
                color: Colors.brown,
                size: 30,
              ),
              title: Text(
                crop["soil"],
                style: const TextStyle(color: Colors.brown, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: const Icon(
                      Icons.thermostat,
                      color: Colors.green,
                      size: 30,
                    ),
                    title: Text(
                      "${crop["temperature"]} °C",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: const Icon(
                      Icons.water_drop_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                    title: Text(
                      "${crop["rain"]} cm",
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: Text(
              "Relative Humidity : ${crop["relative_humidity"]}",
              style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ClimateInfoWidget extends StatelessWidget {
  const ClimateInfoWidget({
    super.key,
    required this.climate,
  });

  final Map climate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.thermostat,
            color: Colors.lightGreen,
            size: 30,
          ),
          title: Text(
            "${climate["temp"]} °C",
            style: const TextStyle(color: Colors.green, fontSize: 18),
          ),
          subtitle: Text(
            "Feels like ${climate["feels_like"]} °C",
            style: const TextStyle(color: Colors.green, fontSize: 18),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.water_drop_outlined,
                  color: Colors.blue,
                  size: 30,
                ),
                title: Text(
                  "Humidity : ${climate["humidity"]}",
                  style: const TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.cloud,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  climate["weather"],
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
