import 'package:flutter/material.dart';
import 'package:gps_homework/application/location_bloc/location_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_homework/application/permission_bloc/permission_cubit.dart';
import 'package:gps_homework/application/view/location_widgets.dart';
import 'package:provider/provider.dart';

import 'geolocator/geoloation_repository.dart';
import 'geolocator/geolocaton_service.dart';
import '../permission_service.dart';

class GpsLocationApp extends StatelessWidget {
  const GpsLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<GeolocationRepository>(
      create: (BuildContext context) => GeolocationRepository(
        geolocationService: GeolocationService(),
        locationService: LocationService(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocationCubit>(
            create: (BuildContext context) =>
                LocationCubit(geolocationRepository: context.read()),
          ),
          BlocProvider<PermissionCubit>(
            create: (BuildContext context) =>
                PermissionCubit(geolocationRepository: context.read()),
          ),
        ],
        child: const InitialWidget(),
      ),
    );
  }
}

class InitialWidget extends StatelessWidget {
  const InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<PermissionCubit>(context);
    return MaterialApp(
      title: 'My location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My location'),
          ),
          body: BlocConsumer<PermissionCubit, PermissionState>(
            listener: (context, state) {
              if (state.serviceEnabled == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Ввімкніть будьласка геолокацію!'),
                  ),
                );
                //doesn't update after enabling location!!!
                dataBloc.checkLocationServiceAccessibilityDelayed(delaySeconds: 4);
              }
            },
            builder: (context, state) {
              return (dataBloc.state.serviceEnabled == true)
                  ? const LocationWidget()
                  : const _DataLoading();
            },
          ),
        ),
      ),
    );
  }
}



class _DataLoading extends StatelessWidget {
  const _DataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
