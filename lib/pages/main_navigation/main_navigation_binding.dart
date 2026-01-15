import 'package:get/get.dart';
import 'package:base_flutter/pages/main_navigation/main_navigation_controller.dart';
import 'package:base_flutter/pages/home/home_binding.dart';
import 'package:base_flutter/pages/setting/setting_binding.dart';
import 'package:base_flutter/pages/notification/notification_binding.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    HomeBinding().dependencies();
    SettingBinding().dependencies();
    NotificationBinding().dependencies();
  }
}

