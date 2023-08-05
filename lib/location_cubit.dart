import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'location_cubit.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());
  StreamSubscription<Position>? positionStream;

  // Stream<Position> currentPosition() {
  //   return Geolocator.getPositionStream();
  // }
  Future<void> currentLocation() async {
    //if( await isLocationServiceEnabled()) {
    //serviceEnabled = true;
    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
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
