import 'package:base_flutter/core/app_info/app_info.dart';
import 'package:base_flutter/core/env/app_env.dart';
import 'package:base_flutter/core/logger/app_logger.dart';
import 'package:base_flutter/core/network/dio_factory.dart';
import 'package:base_flutter/core/storage/token_storage.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/notifications_injection.dart';
import 'package:base_flutter/features/posts/posts_injection.dart';
import 'package:base_flutter/features/settings/settings_injection.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

/// Registers everything the app needs. Each feature owns its registrations
/// in `features/<name>/<name>_injection.dart`.
Future<void> configureDependencies(AppEnv env) async {
  final appInfo = await AppInfo.load();

  getIt
    // Core
    ..registerSingleton<AppEnv>(env)
    ..registerSingleton<AppInfo>(appInfo)
    ..registerLazySingleton<TokenStorage>(
      () => const SecureTokenStorage(FlutterSecureStorage()),
    )
    ..registerLazySingleton<SharedPreferencesAsync>(SharedPreferencesAsync.new)
    ..registerLazySingleton<Dio>(
      () => createDio(
        env: env,
        tokenStorage: getIt(),
        languageCode: () => LocaleSettings.currentLocale.languageCode,
        logger: appLogger,
      ),
    );

  // Shared modules (lib/shared/), registered before the features using them.
  // e.g. registerUsersModule(getIt);

  // Features
  registerSettingsFeature(getIt);
  registerPostsFeature(getIt);
  registerNotificationsFeature(getIt, seed: _demoNotifications);
}

// TODO(team): remove once notifications come from a real source.
List<AppNotification> _demoNotifications() {
  final now = DateTime.now();
  return [
    AppNotification(
      id: 'welcome',
      title: t.welcome,
      message: t.welcome_message,
      type: NotificationType.info,
      createdAt: now,
    ),
    AppNotification(
      id: 'update',
      title: t.update_available,
      message: t.update_available_message,
      type: NotificationType.warning,
      createdAt: now,
    ),
  ];
}
