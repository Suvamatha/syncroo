import 'package:flutter/material.dart';
import 'package:syncroo/features/devices/presentations/cubit/mock_connection_cubit.dart';
import 'package:syncroo/features/devices/presentations/widgets/device_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(const DeviceBridgeApp());
}

class DeviceBridgeApp extends StatelessWidget {
  const DeviceBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Device Bridge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4263EB),
        ),
      ),
      home: BlocProvider(
        create: (_) => MockConnectionCubit(),
        child: const DeviceDashboardPage(),
      )
    );
  }
}

class DeviceDashboardPage extends StatelessWidget {
  const DeviceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Bridge'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  'Your Devices',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8,),
                const Text('UI- prototype - mock data. No1 connections'),
                const SizedBox(height: 24,),
                BlocBuilder<MockConnectionCubit, MockConnectionStatus>(
                  builder: (context, status){
                    final statusLabel = switch(status){
                      MockConnectionStatus.disconnected => 'Disconnected • Simulated',
                      MockConnectionStatus.connected => 'Connected • Simulated',
                      MockConnectionStatus.connecting => 'Connecting • Simulated',
                    };
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DeviceCard(deviceName: 'Samsung S25 Ultra', platformLabel: 'Andriod • Mock device', statusLabel: statusLabel),
                        const SizedBox(height: 8,),
                        FilledButton(
                          onPressed: status== MockConnectionStatus.disconnected
                            ? () => context.read()<MockConnectionCubit>().connect()
                            : null,
                          child: Text(
                            switch(status){
                              MockConnectionStatus.disconnected => 'Connect Mock Devices',
                              MockConnectionStatus.connecting => 'Connecting...',
                              MockConnectionStatus.connected => 'Connected'
                            }
                          )
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}