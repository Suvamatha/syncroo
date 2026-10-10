import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncroo/features/devices/domain/repositories/device_connection_repository.dart';

enum MockConnectionStatus{
  disconnected,
  connected,
  connecting,
  failed,
}

class MockConnectionCubit extends Cubit<MockConnectionStatus>{
  MockConnectionCubit({
    required DeviceConnectionRepository repository,
  }) : _repository = repository,
  super(MockConnectionStatus.disconnected);

  final DeviceConnectionRepository _repository;


  Future<void>connect() async{
    final canConnect = state == MockConnectionStatus.disconnected || state == MockConnectionStatus.failed;

    if(!canConnect) return;
    emit(MockConnectionStatus.connecting);
    final succeeded = await _repository.connect();
    if(isClosed ) return;
     emit(
    succeeded
        ? MockConnectionStatus.connected
        : MockConnectionStatus.failed,
  );
  }

  void disconnect(){
    if(state != MockConnectionStatus.connected) return;
    emit(MockConnectionStatus.disconnected);
  }
}