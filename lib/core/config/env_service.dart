import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/logger.dart';

enum Environment { dev, stag, prod }

class EnvService {
  static Environment? _currentEnvironment;
  static bool _isInitialized = false;

  static Future<void> init(Environment environment) async {
    _currentEnvironment = environment;

    String envFile;
    switch (environment) {
      case Environment.dev:
        envFile = '.env.dev';
        break;
      case Environment.stag:
        envFile = '.env.stag';
        break;
      case Environment.prod:
        envFile = '.env.prod';
        break;
    }

    try {
      await dotenv.load(fileName: envFile);
      _isInitialized = true;
      Logger.i('Environment loaded: $environment', 'EnvService');
      Logger.i('API Base URL: ${getApiBaseUrl()}', 'EnvService');
    } catch (e) {
      Logger.e('Error loading environment file: $e', 'EnvService', e);
      rethrow;
    }
  }

  static Environment get currentEnvironment {
    if (_currentEnvironment == null) {
      throw Exception('Environment not initialized. Call EnvService.init() first.');
    }
    return _currentEnvironment!;
  }

  static bool get isInitialized => _isInitialized;

  static String getApiBaseUrl() {
    return dotenv.env['API_BASE_URL'] ?? '';
  }

  static String getApiKey() {
    return dotenv.env['API_KEY'] ?? '';
  }

  static int getApiTimeout() {
    return int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30') ?? 30;
  }

  static String getAppName() {
    return dotenv.env['APP_NAME'] ?? 'Base Flutter';
  }

  static String getAppVersion() {
    return dotenv.env['APP_VERSION'] ?? '1.0.0';
  }

  static String? getEnv(String key) {
    return dotenv.env[key];
  }

  static bool get isDev => currentEnvironment == Environment.dev;

  static bool get isStag => currentEnvironment == Environment.stag;

  static bool get isProd => currentEnvironment == Environment.prod;
}
