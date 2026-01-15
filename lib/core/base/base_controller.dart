import 'package:get/get.dart';

import 'package:base_flutter/core/utils/logger.dart';
import 'package:base_flutter/services/ui_service.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;

  final RxnString errorMessage = RxnString();

  UiService get _ui => Get.find<UiService>();

  Future<T?> runWithLoading<T>(
    Future<T> Function() action, {
    bool showOverlay = true,
    String? loadingMessage,
    bool rethrowError = false,
  }) async {
    try {
      isLoading.value = true;
      if (showOverlay) {
        Logger.d('Showing loading overlay', runtimeType.toString());
        await _ui.showLoading(message: loadingMessage);
      }

      final result = await action();
      errorMessage.value = null;
      return result;
    } catch (e) {
      final msg = e.toString();
      errorMessage.value = msg;
      Logger.e(msg, runtimeType.toString(), e);
      Logger.d('Hiding loading overlay due to error', runtimeType.toString());
      _ui.showError(msg);

      if (rethrowError) {
        rethrow;
      }
      return null;
    } finally {
      isLoading.value = false;
      if (showOverlay) {
        Logger.d('Hiding loading overlay', runtimeType.toString());
        _ui.hideLoading();
      }
    }
  }
}
