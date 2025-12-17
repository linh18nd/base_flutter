import 'package:get/get.dart';
import 'package:base_flutter/pages/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}



