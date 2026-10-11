import 'package:syncroo/features/devices/domain/entities/device.dart';

abstract class DeviceDiscoveryRepository {
  Future<List<Device>> discovery();
}