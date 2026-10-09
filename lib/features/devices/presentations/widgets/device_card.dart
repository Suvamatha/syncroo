import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String platformLabel;
  final String statusLabel;

  const DeviceCard({
    required this.deviceName,
    required this.platformLabel,
    required this.statusLabel,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              Icons.devices_outlined, size: 32,
            ),
            const SizedBox(width: 32,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deviceName,
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4,),
                  Text(platformLabel),
                  const SizedBox(height: 8,),
                  Text(statusLabel,
                  style: theme.textTheme.labelLarge,
                ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}