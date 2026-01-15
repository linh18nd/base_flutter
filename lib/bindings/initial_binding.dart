import 'package:get/get.dart';
import '../core/network/api_client.dart';
import '../core/storage/storage_service.dart';
import '../data/repositories/post_repository.dart';
import '../services/theme_service.dart';
import '../services/locale_service.dart';
import '../services/ui_service.dart';

class InitialBinding {
  static Future<void> init() async {
    await Get.putAsync<StorageService>(() async {
      final service = StorageService();
      return await service.init();
    }, permanent: true);

    Get.put<ApiClient>(ApiClient(), permanent: true);
    Get.put<PostRepository>(
      PostRepository(Get.find<ApiClient>()),
      permanent: true,
    );

    await Get.putAsync<ThemeService>(() async {
      final themeService = ThemeService();
      return themeService;
    }, permanent: true);

    await Get.putAsync<LocaleService>(() async {
      final localeService = LocaleService();
      return localeService;
    }, permanent: true);

    Get.put<UiService>(UiService(), permanent: true);
  }
}
