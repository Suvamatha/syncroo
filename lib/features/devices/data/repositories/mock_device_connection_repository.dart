import '../../domain/repositories/device_connection_repository.dart';

class MockDeviceConnectionRepository implements DeviceConnectionRepository {
  bool _shouldFailNextAttempt = true ;

  @override
  Future<bool> connect() async{
    await Future<void>.delayed(const Duration(seconds: 2));
    if(_shouldFailNextAttempt) {
      _shouldFailNextAttempt = false;
      return false;
    }
    return true;
  }
}