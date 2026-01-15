import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'notification_controller.dart';
import '../../data/models/notification_model.dart';
import '../../core/utils/localization_extensions.dart';
import '../../core/config/app_theme.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.notification),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: controller.clearAllNotifications,
            tooltip: context.l10n.clearAll,
          ),
        ],
      ),
      body: Obx(
        () => controller.notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 64.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.noNotifications,
                      style: AppTextStyle.t16w400(AppColors.textSecondary),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: notification.isRead
                            ? AppColors.textSecondary
                            : AppColors.primary,
                        child: Icon(
                          notification.type == NotificationType.info
                              ? Icons.info
                              : notification.type == NotificationType.warning
                                  ? Icons.warning
                                  : Icons.error,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        notification.title,
                        style: notification.isRead
                            ? AppTextStyle.t16w400()
                            : AppTextStyle.t16w700(),
                      ),
                      subtitle: Text(
                        notification.message,
                        style:
                            AppTextStyle.t14w400(AppColors.textSecondary),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => controller.removeNotification(index),
                      ),
                      onTap: () => controller.markAsRead(index),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

