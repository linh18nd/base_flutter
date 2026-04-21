import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';

class UiService extends GetxService {
  final _loadingCount = 0.obs;
  OverlayEntry? _loadingEntry;
  bool _isSchedulingShow = false;

  bool get isLoadingShown => _loadingCount.value > 0 && _loadingEntry != null;

  /// Acquire a loading slot and returns a one-shot releaser.
  VoidCallback acquireLoading() {
    _loadingCount.value++;
    _showOverlayIfNeeded();
    var released = false;
    return () {
      if (released) return;
      released = true;
      hideLoading();
    };
  }

  Future<void> showLoading() async {
    acquireLoading();
  }

  void _showOverlayIfNeeded() {
    if (_loadingCount.value <= 0 ||
        _loadingEntry != null ||
        _isSchedulingShow) {
      return;
    }
    _isSchedulingShow = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isSchedulingShow = false;

      if (_loadingCount.value <= 0 || _loadingEntry != null) return;

      final context = Get.overlayContext ?? Get.context;
      if (context == null) {
        unawaited(
          Future<void>.delayed(
            const Duration(milliseconds: 16),
            _showOverlayIfNeeded,
          ),
        );
        return;
      }

      final overlay =
          Get.key.currentState?.overlay ??
          Overlay.maybeOf(context, rootOverlay: true);
      if (overlay == null) {
        unawaited(
          Future<void>.delayed(
            const Duration(milliseconds: 16),
            _showOverlayIfNeeded,
          ),
        );
        return;
      }
      _loadingEntry = OverlayEntry(builder: (_) => const _GlobalLoadingBarrier());
      overlay.insert(_loadingEntry!);
    });
  }

  void hideLoading() {
    if (_loadingCount.value > 0) {
      _loadingCount.value--;
    }
    if (_loadingCount.value <= 0) {
      _loadingCount.value = 0;
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _loadingEntry?.remove();
    _loadingEntry = null;
  }

  void showError(
    String message, {
    String? title,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    if (message.isEmpty) return;

    Get.snackbar(
      title ?? t.error,
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

    Get.snackbar(
      title ?? t.info,
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

class _GlobalLoadingBarrier extends StatelessWidget {
  const _GlobalLoadingBarrier();

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: ColoredBox(
        color: Color(0x66000000),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
