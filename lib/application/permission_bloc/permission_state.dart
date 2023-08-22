part of 'permission_cubit.dart';

class PermissionState extends Equatable {
  const PermissionState({
    this.serviceEnabled = false,
    this.isGranted = false,
  });

  final bool serviceEnabled;
  final bool isGranted;

  PermissionState copyWith({
    bool? serviceEnabled,
    bool? isGranted,
  }) {
    return PermissionState(
      serviceEnabled: serviceEnabled ?? this.serviceEnabled,
      isGranted: isGranted ?? this.isGranted,
    );
  }

  @override
  List<Object?> get props => [serviceEnabled, isGranted];
}
