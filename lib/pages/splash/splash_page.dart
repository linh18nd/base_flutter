import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/pages/splash/splash_controller.dart';
import 'package:base_flutter/core/config/app_theme.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100.sp),
            SizedBox(height: 20.h),
            Text(
              'Base Flutter',
              style: AppTextStyle.t24w700(AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
