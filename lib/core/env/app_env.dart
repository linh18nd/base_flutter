import 'package:flutter/services.dart';

enum Flavor { dev, stag, prod }

/// Environment configuration, resolved from Flutter's built-in [appFlavor].
///
/// Non-secret values (base URL, timeouts) live here per flavor, so a single
/// `--flavor` flag is enough and CLI/CI/IDE builds can never mismatch.
/// Secrets come from `--dart-define-from-file=env/<flavor>.json` (gitignored,
/// see `env/example.json`) and are never bundled as assets.
final class AppEnv {
  const AppEnv._({
    required this.flavor,
    required this.baseUrl,
    required this.apiKey,
    required this.timeout,
  });

  factory AppEnv.fromFlavor(String? flavor) {
    final resolved = switch (flavor) {
      'stag' => Flavor.stag,
      'prod' => Flavor.prod,
      _ => Flavor.dev,
    };

    // TODO(team): replace with the real API host of each flavor.
    final defaultBaseUrl = switch (resolved) {
      Flavor.dev => 'https://jsonplaceholder.typicode.com',
      Flavor.stag => 'https://jsonplaceholder.typicode.com',
      Flavor.prod => 'https://jsonplaceholder.typicode.com',
    };

    return AppEnv._(
      flavor: resolved,
      baseUrl: _overrideBaseUrl.isNotEmpty ? _overrideBaseUrl : defaultBaseUrl,
      apiKey: _apiKey,
      timeout: const Duration(seconds: 30),
    );
  }

  /// Current environment for this build.
  factory AppEnv.current() => AppEnv.fromFlavor(appFlavor);

  static const _apiKey = String.fromEnvironment('API_KEY');
  static const _overrideBaseUrl = String.fromEnvironment('API_BASE_URL');

  final Flavor flavor;
  final String baseUrl;
  final String apiKey;
  final Duration timeout;

  bool get isDev => flavor == Flavor.dev;
  bool get isProd => flavor == Flavor.prod;

  @override
  String toString() => 'AppEnv(flavor: ${flavor.name}, baseUrl: $baseUrl)';
}
