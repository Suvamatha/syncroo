import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/device.dart';
import '../../domain/repositories/device_discovery_repository.dart';

class DeviceDiscoveryState {
  const DeviceDiscoveryState({
    this.isScanning = false,
    this.devices = const [],
    this.errorMessage,
  });

  final bool isScanning;
  final List<Device> devices;
  final String? errorMessage;
}

class DeviceDiscoveryCubit extends Cubit<DeviceDiscoveryState> {
  DeviceDiscoveryCubit({
    required DeviceDiscoveryRepository repository,
  }) : _repository = repository,
       super(const DeviceDiscoveryState());

  final DeviceDiscoveryRepository _repository;

  Future<void> discover() async {
    if (state.isScanning) return;

    emit(const DeviceDiscoveryState(isScanning: true));

    try {
      final devices = await _repository.discovery();

      if (isClosed) return;

      emit(
        DeviceDiscoveryState(
          devices: List<Device>.unmodifiable(devices),
        ),
      );
    } catch (_) {
      if (isClosed) return;

      emit(
        const DeviceDiscoveryState(
          errorMessage: 'Discovery failed. Please try again.',
        ),
      );
    }
  }
}