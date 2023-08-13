import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationPermission? permission;
  bool serviceEnabled = false;
  bool isGranted = false;
  StreamSubscription<Position>? positionStream;

  Future<bool> isLocationServiceEnabled() async {
    locationPermission();
    return await Geolocator.isLocationServiceEnabled();
  }

  void locationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  void requestPermissionIfDeniedForever() {
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
    }
  }
}
