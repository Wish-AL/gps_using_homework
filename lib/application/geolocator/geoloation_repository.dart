import 'dart:async';

import 'package:gps_homework/permission_service.dart';

import '../../models/position.dart';
import 'geolocaton_service.dart';

class GeolocationRepository {
  GeolocationRepository({
    required GeolocationService geolocationService,
    required LocationService locationService,
  })  : _service = geolocationService,
        _locationService = locationService;

  final LocationService _locationService;
  final GeolocationService _service;
  final StreamController<PositionInfo?> _streamController =
      StreamController<PositionInfo>();

  void addInfo() {
    _streamController.add(_service.positionInfo);
  }

  Stream<PositionInfo?> currentPosition() {
    _service.streamOfCurrentPosition();
    addInfo();
    return _streamController.stream;
  }

  void stopStream() {
    _service.stop();
  }

  Future<bool> locationServiceAccessibility() async {
    return await _locationService.isLocationServiceEnabled();
  }

  Future<bool> locationPermissionAccessibility() async {
    _locationService.locationPermission();
    if (_locationService.permissionStatus == LocPermissionStatus.always ||
        _locationService.permissionStatus == LocPermissionStatus.whileInUse) {
      return true;
    } else {
      return false;
    }
  }
}
