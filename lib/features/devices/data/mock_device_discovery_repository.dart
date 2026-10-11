import 'package:syncroo/features/devices/domain/entities/device.dart';
import 'package:syncroo/features/devices/domain/repositories/device_discovery_repository.dart';

class MockDeviceDiscoveryRepository implements DeviceDiscoveryRepository{
  @override
  Future<List<Device>>discovery() async{
    await Future<void>.delayed(const Duration(seconds: 2));
    return const[
      Device(
        id: 'mock-android-01',
        name: 'Samsung S25 Ultra',
        platform: DevicePlatform.android,
      ),
      Device(
        id: 'mock-windows-01',
        name: 'Windows computer',
        platform: DevicePlatform.windows,
      ),
    ];
  }
}