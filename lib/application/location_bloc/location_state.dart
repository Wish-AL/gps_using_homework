part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState._({
    this.latitude = 0,
    this.longitude = 0,
  });

  final double latitude;
  final double longitude;
  const LocationState() : this._();
  const LocationState.addPosition(latitude, longitude) : this._(latitude: latitude, longitude: longitude);
  @override
  List<Object?> get props => [latitude, longitude];
}
