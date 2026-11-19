import 'package:base_flutter/app/router/shell_keys.dart';
import 'package:base_flutter/features/notifications/presentation/notifications_keys.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'support/test_app.dart';

// The app currently starts with two demo notifications, ids "welcome" and
// "update" (see _demoNotifications in lib/app/di/injection.dart).
void main() {
  patrolTest('reading, removing and clearing notifications', ($) async {
    await pumpTestApp($);

    await $(ShellKeys.notificationsTab).tap();
    await $(ShellKeys.notificationsTab).$('2').waitUntilVisible();

    await $(NotificationsKeys.item('welcome')).tap();
    await $(ShellKeys.notificationsTab).$('1').waitUntilVisible();

    await $(NotificationsKeys.removeButton('update')).tap();
    await $.pumpAndSettle();
    expect($(NotificationsKeys.item('update')), findsNothing);

    await $(NotificationsKeys.clearAllButton).tap();
    await $(t.no_notifications).waitUntilVisible();
    expect($(NotificationsKeys.item('welcome')), findsNothing);
  });
}
