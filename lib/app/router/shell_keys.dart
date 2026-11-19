import 'package:material_ui/material_ui.dart';

/// Widget keys shared by the app and E2E tests (patrol_test/).
abstract final class ShellKeys {
  static const homeTab = Key('shell.homeTab');
  static const notificationsTab = Key('shell.notificationsTab');
  static const settingsTab = Key('shell.settingsTab');
}
