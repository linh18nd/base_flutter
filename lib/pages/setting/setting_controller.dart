import 'package:get/get.dart';
import 'package:base_flutter/core/base/base_controller.dart';
import 'package:base_flutter/services/theme_service.dart';
import 'package:base_flutter/services/locale_service.dart';

class SettingController extends BaseController {
  final themeService = Get.find<ThemeService>();
  final localeService = Get.find<LocaleService>();

  Future<void> toggleTheme() async {
    await runWithLoading(() => themeService.toggleTheme(), showOverlay: true);
  }

  Future<void> changeLanguage(String languageCode) async {
    await runWithLoading(
      () => localeService.changeLanguage(languageCode),
      showOverlay: true,
    );
  }
}
