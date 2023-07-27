import 'package:flutter/material.dart';

class GpsLocationApp extends StatelessWidget {
  const GpsLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const Text('location data'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Run'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Stop'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
