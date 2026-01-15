import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_flutter/core/storage/storage_service.dart';
import 'package:base_flutter/core/config/app_config.dart';

class LocaleService extends GetxService {
  final StorageService _storageService = Get.find<StorageService>();
  final _locale = const Locale('vi').obs;

  Locale get locale => _locale.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final savedLanguage = _storageService.getString(AppConfig.keyLanguage);
      if (savedLanguage != null) {
        _locale.value = Locale(savedLanguage);
        await Get.updateLocale(Locale(savedLanguage));
      } else {
        final systemLocale = Get.deviceLocale ?? const Locale('vi');
        _locale.value = systemLocale;
        await Get.updateLocale(systemLocale);
      }
    } catch (e) {
      _locale.value = const Locale('vi');
      await Get.updateLocale(const Locale('vi'));
    }
  }

  Future<void> setLocale(Locale locale) async {
    _locale.value = locale;
    await _storageService.setString(AppConfig.keyLanguage, locale.languageCode);
    await Get.updateLocale(locale);
  }

  Future<void> changeLanguage(String languageCode) async {
    await setLocale(Locale(languageCode));
  }

  static const List<Locale> supportedLocales = [Locale('en'), Locale('vi')];
}
