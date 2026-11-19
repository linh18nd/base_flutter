import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:material_ui/material_ui.dart';

/// Widget keys shared by the app and E2E tests (patrol_test/).
abstract final class SettingsKeys {
  static Key languageOption(String languageCode) =>
      ValueKey('settings.languageOption.$languageCode');
  static Key themeOption(AppThemeMode mode) =>
      ValueKey('settings.themeOption.${mode.name}');
}
