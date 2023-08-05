import 'package:flutter/material.dart';
import 'package:gps_homework/location_cubit.dart';
//import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '../permission_service.dart';

class GpsLocationApp extends StatelessWidget {
  const GpsLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LocationCubit(),
      child: MaterialApp(
        title: 'My location',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('My location'),
            ),
            body: const LocationWidget(),
          ),
        ),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final location = context.read<LocationCubit>();
    return Column(
      children: [
        const LocationDataText(),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                location.currentLocation();
              },
              child: const Text('Run'),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                location.stop();
              },
              child: const Text('Stop'),
            ),
          ],
        )
      ],
    );
  }
}
class LocationDataText extends StatelessWidget {
  const LocationDataText({super.key});

  @override
  Widget build(BuildContext context) {
    //final locationW = context.watch<LocationCubit>();
    return BlocBuilder<LocationCubit, LocationState>(builder: (context, state){
      return Text(
          'Latitude: ${state.latitude ?? 0}, Longitude: ${state.longitude ?? 0}');
    });

  }
}
