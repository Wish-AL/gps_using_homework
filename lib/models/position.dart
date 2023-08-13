import 'package:equatable/equatable.dart';

class PositionInfo extends Equatable{
  final double latitude;
  final double longitude;
  final double speed;

  PositionInfo({
    required this.latitude,
    required this.longitude,
    required this.speed,
  });

  @override
  List<Object?> get props => [latitude, longitude, speed];
}