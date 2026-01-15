import 'package:get/get.dart';
import 'package:base_flutter/core/base/base_controller.dart';
import 'package:base_flutter/data/models/notification_model.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';

class NotificationController extends BaseController {
  final notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleNotifications();
  }

  void _loadSampleNotifications() {
    notifications.addAll([
      NotificationModel(
        title: t.welcome,
        message: t.welcome_message,
        type: NotificationType.info,
        isRead: false,
      ),
      NotificationModel(
        title: t.update_available,
        message: t.update_available_message,
        type: NotificationType.warning,
        isRead: false,
      ),
    ]);
  }

  void addNotification(NotificationModel notification) {
    notifications.insert(0, notification);
  }

  void removeNotification(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
    }
  }

  void markAsRead(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index].isRead = true;
      notifications.refresh();
    }
  }

  void clearAllNotifications() {
    notifications.clear();
  }

  int get unreadCount {
    return notifications.where((n) => !n.isRead).length;
  }
}

