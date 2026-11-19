import 'package:get/get.dart';

import 'package:base_flutter/core/base/base_controller.dart';
import 'package:base_flutter/data/models/post_model.dart';
import 'package:base_flutter/data/repositories/post_repository.dart';
import 'package:base_flutter/services/locale_service.dart';
import 'package:base_flutter/services/theme_service.dart';

class HomeController extends BaseController {
  final counter = 0.obs;
  final themeService = Get.find<ThemeService>();
  final localeService = Get.find<LocaleService>();
  final PostRepository _postRepository = Get.find<PostRepository>();

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
      posts.assignAll(await _postRepository.getPosts());
    });
  }
}
