import 'dart:async';

import 'package:gps_homework/geolocaton_service.dart';

import 'models/position.dart';

class GeolocationRepository {
  GeolocationRepository({required GeolocationService geolocationService})
      : _service = geolocationService;
  final GeolocationService _service;
  final StreamController<PositionInfo?> _streamController =
      StreamController<PositionInfo>();

  void addInfo() {
    _streamController.add(_service.positionInfo);
  }

  Stream<PositionInfo?> currentPosition()  {
    _service.streamOfCurrentPosition();
    addInfo();
    return _streamController.stream;
  }
  void storStream(){
    _service.stop();
  }
}
