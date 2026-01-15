import 'package:get/get.dart';
import 'package:base_flutter/core/network/api_client.dart';
import 'package:base_flutter/core/storage/storage_service.dart';
import 'package:base_flutter/data/repositories/post_repository.dart';
import 'package:base_flutter/services/theme_service.dart';
import 'package:base_flutter/services/locale_service.dart';
import 'package:base_flutter/services/ui_service.dart';

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
