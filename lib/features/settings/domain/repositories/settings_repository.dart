import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';

abstract interface class SettingsRepository {
  Future<Result<AppSettings>> load();

  Future<Result<void>> saveThemeMode(AppThemeMode mode);

  Future<Result<void>> saveLanguage(String languageCode);
}
