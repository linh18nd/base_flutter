import 'package:base_flutter/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_flutter/core/config/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: themeService.themeMode == ThemeMode.dark
                ? AppColors.background
                : AppColors.primary,
          ),

          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message!, style: AppTextStyle.t16w400()),
          ],
        ],
      ),
    );
  }
}
