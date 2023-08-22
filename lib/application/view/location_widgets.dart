import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../location_bloc/location_cubit.dart';

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
    return BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
      return Text('Latitude: ${state.latitude}, Longitude: ${state.longitude}');
    });
  }
}