import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/features/notifications/domain/entities/app_notification.dart';
import 'package:base_flutter/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:base_flutter/features/notifications/presentation/notifications_keys.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final cubit = context.read<NotificationsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(t.notification),
        actions: [
          IconButton(
            key: NotificationsKeys.clearAllButton,
            icon: const Icon(Icons.clear_all),
            tooltip: t.clear_all,
            onPressed: cubit.clearAll,
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return MessageView(
              icon: Icons.notifications_none,
              message: t.no_notifications,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return _NotificationCard(
                notification: item,
                onTap: () => cubit.markAsRead(item.id),
                onRemove: () => cubit.remove(item.id),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onRemove,
  });

  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isRead = notification.isRead;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        key: NotificationsKeys.item(notification.id),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: isRead
              ? colors.surfaceContainerHighest
              : colors.primaryContainer,
          foregroundColor: isRead
              ? colors.onSurfaceVariant
              : colors.onPrimaryContainer,
          child: Icon(switch (notification.type) {
            NotificationType.info => Icons.info_outline,
            NotificationType.warning => Icons.warning_amber,
            NotificationType.error => Icons.error_outline,
          }),
        ),
        title: Text(
          notification.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: isRead ? FontWeight.normal : FontWeight.w700,
          ),
        ),
        subtitle: Text(notification.message),
        trailing: IconButton(
          key: NotificationsKeys.removeButton(notification.id),
          icon: const Icon(Icons.close),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
