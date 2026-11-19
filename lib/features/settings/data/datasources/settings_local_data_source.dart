import 'package:shared_preferences/shared_preferences.dart';

final class SettingsLocalDataSource {
  const SettingsLocalDataSource(this._prefs);

  static const _themeModeKey = 'settings.theme_mode';
  static const _languageKey = 'settings.language';

  final SharedPreferencesAsync _prefs;

  Future<String?> readThemeMode() => _prefs.getString(_themeModeKey);

  Future<void> writeThemeMode(String value) =>
      _prefs.setString(_themeModeKey, value);

  Future<String?> readLanguage() => _prefs.getString(_languageKey);

  Future<void> writeLanguage(String value) =>
      _prefs.setString(_languageKey, value);
}
