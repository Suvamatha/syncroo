enum DevicePlatform{
  android,
  ios,
  linux,
  windows,
  macos
}
class Device {
  const Device({
    required this.id,
    required this.name,
    required this.platform,
  });
  final String id;
  final String name;
  final DevicePlatform platform;
}