import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/device_discovery_cubit.dart';
import 'device_card.dart';

class DeviceDiscoverySection extends StatelessWidget {
  const DeviceDiscoverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceDiscoveryCubit, DeviceDiscoveryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Discovered devices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Mock discovery only. These devices are not connected.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: state.isScanning
                  ? null
                  : () => context
                      .read<DeviceDiscoveryCubit>()
                      .discover(),
              child: Text(
                state.isScanning
                    ? 'Discovering…'
                    : 'Discover mock devices',
              ),
            ),
            const SizedBox(height: 16),
            if (state.isScanning)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (state.errorMessage != null)
              Text(state.errorMessage!)
            else if (state.devices.isEmpty)
              const Text(
                'No results yet. Tap Discover mock devices.',
              )
            else
              for (final device in state.devices)
                Padding(
                  key: ValueKey(device.id),
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DeviceCard(
                    deviceName: device.name,
                    platformLabel: device.platform.name,
                    statusLabel: 'Discovered • Simulated',
                  ),
                ),
          ],
        );
      },
    );
  }
}