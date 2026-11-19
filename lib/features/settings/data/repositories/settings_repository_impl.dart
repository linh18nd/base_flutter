import 'package:base_flutter/core/error/guard.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/repositories/settings_repository.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  Future<Result<AppSettings>> load() => guardStorage(() async {
    final themeName = await _local.readThemeMode();
    return AppSettings(
      themeMode: AppThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => AppThemeMode.system,
      ),
      languageCode: await _local.readLanguage(),
    );
  });

  @override
  Future<Result<void>> saveThemeMode(AppThemeMode mode) =>
      guardStorage(() => _local.writeThemeMode(mode.name));

  @override
  Future<Result<void>> saveLanguage(String languageCode) =>
      guardStorage(() => _local.writeLanguage(languageCode));
}
