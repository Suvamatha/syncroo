import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/device.dart';
import '../cubit/mock_connection_cubit.dart';
import 'device_card.dart';

class DiscoveredDeviceCard extends StatelessWidget {
  const DiscoveredDeviceCard({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
        MockConnectionCubit,
        Map<String, MockConnectionStatus>,
        MockConnectionStatus>(
      selector: (states) =>
          states[device.id] ?? MockConnectionStatus.disconnected,
      builder: (context, status) {
        final label = switch (status) {
          MockConnectionStatus.disconnected => 'Disconnected',
          MockConnectionStatus.connecting => 'Connecting…',
          MockConnectionStatus.connected => 'Connected',
          MockConnectionStatus.failed => 'Connection failed',
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DeviceCard(
              deviceName: device.name,
              platformLabel: device.platform.name,
              statusLabel: '$label • Simulated',
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: status == MockConnectionStatus.connecting
                  ? null
                  : () {
                      final cubit =
                          context.read<MockConnectionCubit>();

                      if (status == MockConnectionStatus.connected) {
                        cubit.disconnect(device.id);
                      } else {
                        cubit.connect(device.id);
                      }
                    },
              child: Text(
                switch (status) {
                  MockConnectionStatus.disconnected => 'Connect',
                  MockConnectionStatus.connecting => 'Connecting…',
                  MockConnectionStatus.connected => 'Disconnect',
                  MockConnectionStatus.failed => 'Retry',
                },
              ),
            ),
          ],
        );
      },
    );
  }
}//