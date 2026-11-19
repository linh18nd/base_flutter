import 'package:base_flutter/app/router/shell_keys.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/presentation/settings_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:patrol/patrol.dart';

import 'support/test_app.dart';

ThemeMode _themeMode(PatrolIntegrationTester $) =>
    $.tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode!;

void main() {
  patrolTest('settings switch to dark mode and Vietnamese', ($) async {
    await pumpTestApp($);

    await $(ShellKeys.settingsTab).tap();
    await $(SettingsKeys.themeOption(AppThemeMode.dark)).tap();
    await $(SettingsKeys.languageOption('vi')).tap();
    await $('Cài đặt').waitUntilVisible();
    expect(_themeMode($), ThemeMode.dark);

    await $(ShellKeys.homeTab).tap();
    await $('Trang chủ').waitUntilVisible();
  });

  patrolTest('settings are kept after reopening the app', ($) async {
    await pumpTestApp($);
    await $(ShellKeys.settingsTab).tap();
    await $(SettingsKeys.themeOption(AppThemeMode.dark)).tap();
    await $(SettingsKeys.languageOption('vi')).tap();
    await $('Cài đặt').waitUntilVisible();

    await restartTestApp($);

    await $('Trang chủ').waitUntilVisible();
    expect(_themeMode($), ThemeMode.dark);
  });
}
