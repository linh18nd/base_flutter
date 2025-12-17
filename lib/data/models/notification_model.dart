enum NotificationType {
  info,
  warning,
  error,
}

class NotificationModel {
  final String title;
  final String message;
  final NotificationType type;
  bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}



