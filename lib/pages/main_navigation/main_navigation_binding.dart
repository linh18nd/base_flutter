import 'package:get/get.dart';
import 'main_navigation_controller.dart';
import '../home/home_binding.dart';
import '../setting/setting_binding.dart';
import '../notification/notification_binding.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    HomeBinding().dependencies();
    SettingBinding().dependencies();
    NotificationBinding().dependencies();
  }
}

