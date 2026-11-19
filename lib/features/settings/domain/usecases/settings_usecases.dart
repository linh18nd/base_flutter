import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/repositories/settings_repository.dart';

class GetSettings {
  const GetSettings(this._repository);

  final SettingsRepository _repository;

  Future<Result<AppSettings>> call() => _repository.load();
}

class UpdateThemeMode {
  const UpdateThemeMode(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call(AppThemeMode mode) =>
      _repository.saveThemeMode(mode);
}

class UpdateLanguage {
  const UpdateLanguage(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call(String languageCode) =>
      _repository.saveLanguage(languageCode);
}
