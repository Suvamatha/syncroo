import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/device_connection_repository.dart';

enum MockConnectionStatus {
  disconnected,
  connecting,
  connected,
  failed,
}

class MockConnectionCubit
    extends Cubit<Map<String, MockConnectionStatus>> {
  MockConnectionCubit({
    required DeviceConnectionRepository repository,
  }) : _repository = repository,
       super(const {});

  final DeviceConnectionRepository _repository;

  Future<void> connect(String deviceId) async {
    final current =
        state[deviceId] ?? MockConnectionStatus.disconnected;

    if (current == MockConnectionStatus.connecting ||
        current == MockConnectionStatus.connected) {
      return;
    }

    _update(deviceId, MockConnectionStatus.connecting);

    try {
      final succeeded = await _repository.connect(deviceId);

      if (isClosed) return;

      _update(
        deviceId,
        succeeded
            ? MockConnectionStatus.connected
            : MockConnectionStatus.failed,
      );
    } catch (_) {
      if (isClosed) return;

      _update(deviceId, MockConnectionStatus.failed);
    }
  }

  void disconnect(String deviceId) {
    if (state[deviceId] != MockConnectionStatus.connected) return;

    _update(deviceId, MockConnectionStatus.disconnected);
  }

  void _update(String deviceId, MockConnectionStatus status) {
    emit(
      Map<String, MockConnectionStatus>.unmodifiable({
        ...state,
        deviceId: status,
      }),
    );
  }
}