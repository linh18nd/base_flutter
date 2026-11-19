import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/settings/domain/repositories/settings_repository.dart';

class UpdateLanguage {
  const UpdateLanguage(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call(String languageCode) =>
      _repository.saveLanguage(languageCode);
}
