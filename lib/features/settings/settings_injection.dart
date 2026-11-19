import 'package:base_flutter/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:base_flutter/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/repositories/settings_repository.dart';
import 'package:base_flutter/features/settings/domain/usecases/get_settings.dart';
import 'package:base_flutter/features/settings/domain/usecases/update_language.dart';
import 'package:base_flutter/features/settings/domain/usecases/update_theme_mode.dart';
import 'package:base_flutter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:get_it/get_it.dart';

void registerSettingsFeature(GetIt getIt) {
  getIt
    // Data
    ..registerLazySingleton(() => SettingsLocalDataSource(getIt()))
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt()),
    )
    // Domain
    ..registerFactory(() => GetSettings(getIt()))
    ..registerFactory(() => UpdateThemeMode(getIt()))
    ..registerFactory(() => UpdateLanguage(getIt()))
    // Presentation: needs the settings loaded at startup.
    ..registerFactoryParam<SettingsCubit, AppSettings, void>(
      (initial, _) => SettingsCubit(
        initial: initial,
        updateThemeMode: getIt(),
        updateLanguage: getIt(),
      ),
    );
}
