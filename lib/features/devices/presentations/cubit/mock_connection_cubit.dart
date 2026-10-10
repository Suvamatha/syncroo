import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MockConnectionStatus{
  disconnected,
  connected,
  connecting,
  failed,
}

class MockConnectionCubit extends Cubit<MockConnectionStatus>{
  MockConnectionCubit() : super(MockConnectionStatus.disconnected);

  bool _shouldFailNextAttempt = false;

  Future<void>connect() async{
    final canConnect = state == MockConnectionStatus.disconnected || state == MockConnectionStatus.failed;
    if(!canConnect) return;
    emit(MockConnectionStatus.connecting);
    await Future<void>.delayed(const Duration(seconds: 2));
    if(isClosed) return;
    if(_shouldFailNextAttempt){
      _shouldFailNextAttempt = false;
      emit(MockConnectionStatus.failed);
      return;
    }
    emit(MockConnectionStatus.connected);
    if(state != MockConnectionStatus.disconnected) return;

    emit(MockConnectionStatus.connecting);
    await Future<void>.delayed(const Duration(seconds: 2));
    if(isClosed)return;
    emit(MockConnectionStatus.connected);
  }

  void disconnect(){
    if(state != MockConnectionStatus.connected) return;
    emit(MockConnectionStatus.disconnected);
  }
}