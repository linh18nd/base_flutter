import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/logger.dart';
import '../widgets/loading_widget.dart';

class UiService extends GetxService {
  final _isLoadingShown = false.obs;

  bool get isLoadingShown => _isLoadingShown.value;

  Future<void> showLoading({String? message}) async {
    if (_isLoadingShown.value) return;
    _isLoadingShown.value = true;

    Logger.d('Show global loading', 'UiService');

    if (Get.overlayContext != null || Get.context != null) {
      unawaited(
        Get.dialog<void>(
          PopScope(canPop: false, child: LoadingWidget(message: message)),
          barrierDismissible: false,
        ),
      );
    }
  }

  void hideLoading() {
    if (!_isLoadingShown.value) return;

    Logger.d('Hide global loading', 'UiService');

    if (Get.isDialogOpen ?? false) {
      Get.back<void>();
    }
    _isLoadingShown.value = false;
  }

  void showError(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    if (message.isEmpty) return;

    Logger.e('Show error snackbar: $message', 'UiService');

    Get.snackbar(
      title ?? 'Error',
      message,
      snackPosition: position,
      backgroundColor: Colors.red.shade200,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  void showInfo(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    if (message.isEmpty) return;

    Logger.i('Show info snackbar: $message', 'UiService');

    Get.snackbar(
      title ?? 'Info',
      message,
      snackPosition: position,
      backgroundColor: Colors.blue.shade200,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}
