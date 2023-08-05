import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? position;
  LocationPermission? permission;
  bool serviceEnabled = false;
  bool isGranted = false;
  StreamSubscription<Position>? positionStream;
  double? latitude;
  double? longitude;

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

  void getOnceTimeLocation() async {
    position = await Geolocator.getCurrentPosition();

  }


  Future<void> currentLocation() async {
    if( await isLocationServiceEnabled()) {
      //serviceEnabled = true;
      positionStream =
          Geolocator.getPositionStream().listen((Position? position) {
            latitude = position?.latitude;
            longitude = position?.longitude;

          });
    }
  }
  void stop() {
    positionStream?.cancel();
  }
}
