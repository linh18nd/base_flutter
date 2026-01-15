import 'package:get/get.dart';
import '../../core/base/base_controller.dart';
import '../../data/models/notification_model.dart';

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
        title: 'Welcome',
        message: 'Welcome to Base Flutter App',
        type: NotificationType.info,
        isRead: false,
      ),
      NotificationModel(
        title: 'Update Available',
        message: 'A new version of the app is available',
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

