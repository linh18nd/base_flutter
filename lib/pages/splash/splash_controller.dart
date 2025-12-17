import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:base_flutter/core/base/base_controller.dart';
import 'package:base_flutter/routes/app_pages.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _navigateToMain();
    });
  }

  Future<void> _navigateToMain() async {
    await runWithLoading(() async {
      await Future.delayed(const Duration(seconds: 2));
      await Get.offAllNamed(Routes.mainNavigation);
    }, showOverlay: false);
  }
}
