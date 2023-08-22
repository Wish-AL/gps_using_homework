import 'dart:async';
import 'package:geolocator/geolocator.dart';

enum LocPermissionStatus { denied, deniedForever, whileInUse, always }

class LocationService {
  LocPermissionStatus? permissionStatus;

  StreamSubscription<Position>? positionStream;

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  void locationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    switch (permission) {
      case LocationPermission.denied:
        permissionStatus = LocPermissionStatus.denied;
      case LocationPermission.always:
        permissionStatus = LocPermissionStatus.always;
      case LocationPermission.deniedForever:
        permissionStatus = LocPermissionStatus.deniedForever;
      case LocationPermission.whileInUse:
        permissionStatus = LocPermissionStatus.whileInUse;
      default:
        Future.error('Location permissions error in switch case');
    }
  }

  void requestPermissionIfDeniedForever() {
    if (permissionStatus == LocPermissionStatus.deniedForever) {
      // Permissions are denied forever, handle appropriately.
    }
  }
}
