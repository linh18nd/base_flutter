import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:get/get.dart';

import 'package:base_flutter/core/base/base_controller.dart';
import 'package:base_flutter/core/utils/logger.dart';
import 'package:base_flutter/data/models/post_model.dart';
import 'package:base_flutter/data/repositories/post_repository.dart';
import 'package:base_flutter/services/locale_service.dart';
import 'package:base_flutter/services/theme_service.dart';
import 'package:base_flutter/services/ui_service.dart';

class HomeController extends BaseController {
  final counter = 0.obs;
  final themeService = Get.find<ThemeService>();
  final localeService = Get.find<LocaleService>();
  final PostRepository _postRepository = Get.find<PostRepository>();
  final UiService _uiService = Get.find<UiService>();

  final posts = <Post>[].obs;

  void incrementCounter() {
    counter.value++;
  }

  Future<void> toggleTheme() async {
    await runWithLoading(() => themeService.toggleTheme());
  }

  Future<void> changeLanguage(String languageCode) async {
    await runWithLoading(() => localeService.changeLanguage(languageCode));
  }

  Future<void> loadPosts() async {
    await runWithLoading(() async {
      Logger.d('Start loadPosts()', runtimeType.toString());
      final response = await _postRepository.getPosts();
      if (response.success && response.data != null) {
        posts.assignAll(response.data!);
        errorMessage.value = null;
        Logger.d(
          'Loaded ${response.data!.length} posts',
          runtimeType.toString(),
        );
      } else {
        final msg = response.message ?? t.failed_to_load_posts;
        errorMessage.value = msg;
        Logger.e(msg, runtimeType.toString(), response.error);
        _uiService.showError(msg);
      }
    });
  }
}
