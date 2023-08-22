import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../geolocator/geoloation_repository.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit({required GeolocationRepository geolocationRepository})
      : _repository = geolocationRepository,
        super(const PermissionState()) {
    _initPermission();
  }

  final GeolocationRepository _repository;

  Future<void> _initPermission() async {
    final serviceEnabled = await _repository.locationServiceAccessibility();
    final isGranted = await _repository.locationPermissionAccessibility();
    emit(state.copyWith(
      serviceEnabled: serviceEnabled,
      isGranted: isGranted,
    ));
  }


  Future<void> checkLocationServiceAccessibility() async {
    final serviceEnabled = await _repository.locationServiceAccessibility();
    emit(state.copyWith(
      serviceEnabled: serviceEnabled,
    ));
  }

  Future<void> checkLocationServiceAccessibilityDelayed(
      {int delaySeconds = 4}) async {
    bool serviceEnabled = false;

      Future.delayed(
        Duration(seconds: delaySeconds),
        () async {
          serviceEnabled = await _repository.locationServiceAccessibility();
        },
      );

    emit(state.copyWith(
      serviceEnabled: serviceEnabled,
    ));
  }

  Future<void> checkLocationPermission() async {
    final isGranted = await _repository.locationPermissionAccessibility();
    emit(state.copyWith(
      isGranted: isGranted,
    ));
  }
}
