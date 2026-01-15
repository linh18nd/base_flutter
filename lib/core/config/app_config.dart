import 'env_service.dart';

class AppConfig {
  static String get baseUrl => EnvService.getApiBaseUrl();
  static String get apiKey => EnvService.getApiKey();
  static Duration get connectTimeout =>
      Duration(seconds: EnvService.getApiTimeout());
  static Duration get receiveTimeout =>
      Duration(seconds: EnvService.getApiTimeout());

  static const String keyToken = 'token';
  static const String keyUser = 'user';
  static const String keyLanguage = 'language';
  static const String keyTheme = 'theme';

  static String get appName => EnvService.getAppName();
  static String get appVersion => EnvService.getAppVersion();

  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  static bool get isDev => EnvService.isDev;
  static bool get isStag => EnvService.isStag;
  static bool get isProd => EnvService.isProd;
}

