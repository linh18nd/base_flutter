import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/logger/app_logger.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/domain/usecases/settings_usecases.dart';
import 'package:bloc/bloc.dart';

/// App-level cubit; the state drives `MaterialApp.themeMode` and the locale.
///
/// Changes apply immediately and are persisted in the background; a failed
/// write is logged and the in-memory choice is kept for this session.
class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit({
    required AppSettings initial,
    required this._updateThemeMode,
    required this._updateLanguage,
  }) : super(initial);

  final UpdateThemeMode _updateThemeMode;
  final UpdateLanguage _updateLanguage;

  Future<void> setThemeMode(AppThemeMode mode) async {
    if (mode == state.themeMode) return;
    emit(state.copyWith(themeMode: mode));
    _logIfFailed(await _updateThemeMode(mode));
  }

  Future<void> setLanguage(String languageCode) async {
    if (languageCode == state.languageCode) return;
    emit(state.copyWith(languageCode: languageCode));
    _logIfFailed(await _updateLanguage(languageCode));
  }

  void _logIfFailed(Result<void> result) {
    if (result case Err(:final failure)) {
      appLogger.w('Could not persist settings: $failure');
    }
  }
}
