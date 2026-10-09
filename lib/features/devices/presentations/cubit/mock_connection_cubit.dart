import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MockConnectionStatus{
  disconnected,
  connected,
  connecting,
}

class MockConnectionCubit extends Cubit<MockConnectionStatus>{
  MockConnectionCubit() : super(MockConnectionStatus.disconnected);

  Future<void>connect() async{
    if(state != MockConnectionStatus.disconnected) return;

    emit(MockConnectionStatus.connecting);
    await Future<void>.delayed(const Duration(seconds: 2));
    if(isClosed)return;
    emit(MockConnectionStatus.connected);
  }
}