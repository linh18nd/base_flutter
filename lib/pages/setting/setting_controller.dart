import 'package:get/get.dart';
import '../../core/base/base_controller.dart';
import '../../services/theme_service.dart';
import '../../services/locale_service.dart';

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
