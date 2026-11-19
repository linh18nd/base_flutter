import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/logger/app_logger.dart';
import 'package:base_flutter/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/repositories/settings_repository.dart';

final class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  Future<Result<AppSettings>> load() => _storage(() async {
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
      _storage(() => _local.writeThemeMode(mode.name));

  @override
  Future<Result<void>> saveLanguage(String languageCode) =>
      _storage(() => _local.writeLanguage(languageCode));

  Future<Result<T>> _storage<T>(Future<T> Function() action) async {
    try {
      return Ok(await action());
    } on Object catch (e, stackTrace) {
      appLogger.e('Settings storage failed', error: e, stackTrace: stackTrace);
      return Err(StorageFailure(cause: e));
    }
  }
}
