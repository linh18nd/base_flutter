import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:base_flutter/core/network/app_exception.dart';
import 'package:base_flutter/core/utils/logger.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:base_flutter/services/ui_service.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;

  final RxnString errorMessage = RxnString();

  UiService get _ui => Get.find<UiService>();

  /// Runs [action] with loading state and is the single place where errors
  /// are turned into user-facing messages.
  ///
  /// [AppException] shows its localized message; any other error is logged
  /// and shown as a generic message so raw exception text never reaches users.
  /// Cancelled requests are ignored silently.
  Future<T?> runWithLoading<T>(
    Future<T> Function() action, {
    bool showOverlay = true,
    bool showError = true,
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
    } on AppException catch (e) {
      Logger.e(e.message, runtimeType.toString(), e.cause);
      if (!e.isCancelled) {
        errorMessage.value = e.message;
        errorToShow = e.message;
      }
      if (rethrowError) {
        rethrow;
      }
      return null;
    } catch (e, stackTrace) {
      Logger.e('Unexpected error', runtimeType.toString(), e, stackTrace);
      errorMessage.value = t.an_error_occurred;
      errorToShow = t.an_error_occurred;
      if (rethrowError) {
        rethrow;
      }
      return null;
    } finally {
      isLoading.value = false;
      releaseLoading?.call();
      if (showError && errorToShow != null) {
        _ui.showError(errorToShow);
      }
    }
  }
}
