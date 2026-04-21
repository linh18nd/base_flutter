import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:base_flutter/services/ui_service.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;

  final RxnString errorMessage = RxnString();

  UiService get _ui => Get.find<UiService>();

  Future<T?> runWithLoading<T>(
    Future<T> Function() action, {
    bool showOverlay = true,
    bool rethrowError = false,
  }) async {
    String? errorToShow;
    VoidCallback? releaseLoading;
    try {
      isLoading.value = true;
      if (showOverlay) {
        releaseLoading = _ui.acquireLoading();
      }

      final result = await action();
      errorMessage.value = null;
      return result;
    } catch (e) {
      final msg = e.toString();
      errorMessage.value = msg;
      errorToShow = msg;

      if (rethrowError) {
        rethrow;
      }
      return null;
    } finally {
      isLoading.value = false;
      releaseLoading?.call();
      if (errorToShow != null) {
        _ui.showError(errorToShow);
      }
    }
  }
}
