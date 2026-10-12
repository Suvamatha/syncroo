import '../../domain/repositories/device_connection_repository.dart';

class MockDeviceConnectionRepository implements DeviceConnectionRepository {
  final Set<String> _attemptedDeviceIds ={};

  @override
  Future<bool> connect(String deviceId) async{
    await Future<void>.delayed(const Duration(seconds: 1));
    final isFirstAttempt = _attemptedDeviceIds.add(deviceId);
    return !isFirstAttempt;
  }
}