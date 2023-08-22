import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '/models/position.dart';

class GeolocationService {
  StreamSubscription<Position>? positionStream;
  late PositionInfo? positionInfo;

  Future<PositionInfo> getOnceTimeLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return PositionInfo(
      latitude: position.latitude,
      longitude: position.longitude,
      speed: position.speed,
    );
  }

  Future<void> streamOfCurrentPosition() async {
    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      positionInfo = PositionInfo(
        latitude: position!.latitude,
        longitude: position.longitude,
        speed: position.speed,
      );
    });
  }

  void stop() {
    positionStream?.cancel();
  }
}
