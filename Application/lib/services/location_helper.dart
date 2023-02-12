import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;

class LocationHelper {
  double latitude = 0, longitude = 0;

  Future<void> getCurrentLocation() async {
    Position position;
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      developer.log(latitude.toString());
      developer.log(longitude.toString());
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
