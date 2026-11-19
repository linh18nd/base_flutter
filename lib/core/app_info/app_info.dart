import 'package:package_info_plus/package_info_plus.dart';

/// Name and version of the running build, read from the platform.
final class AppInfo {
  const AppInfo({
    required this.appName,
    required this.version,
    required this.buildNumber,
  });

  static Future<AppInfo> load() async {
    final info = await PackageInfo.fromPlatform();
    return AppInfo(
      appName: info.appName,
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }

  final String appName;
  final String version;
  final String buildNumber;
}
