import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:base_flutter/core/storage/storage_service.dart';
import 'package:base_flutter/core/config/app_config.dart';

class ThemeService extends GetxService {
  StorageService get _storageService => Get.find<StorageService>();
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  void _loadThemeMode() {
    try {
      final savedTheme = _storageService.getString(AppConfig.keyTheme);
      if (savedTheme != null) {
        switch (savedTheme) {
          case 'light':
            _themeMode.value = ThemeMode.light;
            break;
          case 'dark':
            _themeMode.value = ThemeMode.dark;
            break;
          default:
            _themeMode.value = ThemeMode.system;
        }
      }
    } catch (e) {
      // StorageService not ready yet, use default theme
      _themeMode.value = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode.value = mode;
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    await _storageService.setString(AppConfig.keyTheme, themeString);
    Get.changeThemeMode(mode);
  }

  Future<void> toggleTheme() async {
    if (_themeMode.value == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  static ThemeData getLightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    );
  }

  static ThemeData getDarkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    );
  }
}

