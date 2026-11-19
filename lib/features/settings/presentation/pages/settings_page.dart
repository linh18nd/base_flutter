import 'dart:async';

import 'package:base_flutter/core/app_info/app_info.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final appInfo = context.read<AppInfo>();
    final cubit = context.read<SettingsCubit>();
    final settings = context.watch<SettingsCubit>().state;
    final currentLanguage =
        settings.languageCode ??
        TranslationProvider.of(context).flutterLocale.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(t.setting)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: t.theme_mode,
            child: RadioGroup<AppThemeMode>(
              groupValue: settings.themeMode,
              onChanged: (mode) {
                if (mode != null) unawaited(cubit.setThemeMode(mode));
              },
              child: Column(
                children: [
                  RadioListTile(
                    value: AppThemeMode.system,
                    title: Text(t.system_mode),
                    secondary: const Icon(Icons.brightness_auto),
                  ),
                  RadioListTile(
                    value: AppThemeMode.light,
                    title: Text(t.light_mode),
                    secondary: const Icon(Icons.light_mode),
                  ),
                  RadioListTile(
                    value: AppThemeMode.dark,
                    title: Text(t.dark_mode),
                    secondary: const Icon(Icons.dark_mode),
                  ),
                ],
              ),
            ),
          ),
          _Section(
            title: t.language,
            child: RadioGroup<String>(
              groupValue: currentLanguage,
              onChanged: (code) {
                if (code != null) unawaited(cubit.setLanguage(code));
              },
              child: Column(
                children: [
                  RadioListTile(value: 'vi', title: Text(t.vietnamese)),
                  RadioListTile(value: 'en', title: Text(t.english)),
                ],
              ),
            ),
          ),
          _Section(
            title: t.app_info,
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(appInfo.appName),
              subtitle: Text(
                t.app_version(
                  version: appInfo.version,
                  build: appInfo.buildNumber,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
