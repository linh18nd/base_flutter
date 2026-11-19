import 'package:flutter/services.dart';

import 'package:base_flutter/core/config/env_service.dart';
import 'package:base_flutter/core/utils/logger.dart';

class FlavorConfig {
  FlavorConfig._();

  /// Resolves the environment from Flutter's built-in [appFlavor], which the
  /// tool sets from `--flavor` (Android) or the Xcode build configuration
  /// (iOS), so CLI, CI and IDE builds always agree.
  static Environment get currentFlavor {
    switch (appFlavor) {
      case 'dev':
        return Environment.dev;
      case 'stag':
        return Environment.stag;
      case 'prod':
        return Environment.prod;
      default:
        Logger.w(
          'Unknown or missing flavor "$appFlavor", falling back to dev. '
          'Run with --flavor dev|stag|prod.',
          'FlavorConfig',
        );
        return Environment.dev;
    }
  }

  static Future<void> init() async {
    await EnvService.init(currentFlavor);
  }
}
