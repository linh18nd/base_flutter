import 'package:material_ui/material_ui.dart';

/// Widget keys shared by the app and E2E tests (patrol_test/).
abstract final class NotificationsKeys {
  static const clearAllButton = Key('notifications.clearAllButton');
  static Key item(String notificationId) =>
      ValueKey('notifications.item.$notificationId');
  static Key removeButton(String notificationId) =>
      ValueKey('notifications.removeButton.$notificationId');
}
