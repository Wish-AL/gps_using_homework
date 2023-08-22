import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_homework/application/geolocator/geoloation_repository.dart';

import '../../models/position.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required GeolocationRepository geolocationRepository})
      : _repository = geolocationRepository,
        super(const LocationState());

  StreamSubscription<PositionInfo?>? positionStream;
  final GeolocationRepository _repository;

  void getOnceTimeLocation() async {
    Position position = await Geolocator.getCurrentPosition();
  }

  Future<void> currentLocation() async {
    //if( await isLocationServiceEnabled()) {
    //serviceEnabled = true;
    positionStream = _repository.currentPosition().listen((PositionInfo? position) {
      emit(LocationState.addPosition(
        position?.latitude,
        position?.longitude,
      ));
    });
    //}
  }

  void stop() {
    positionStream?.cancel();
  }
}
