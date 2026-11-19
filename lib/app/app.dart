import 'package:base_flutter/app/di/injection.dart';
import 'package:base_flutter/app/router/app_router.dart';
import 'package:base_flutter/core/app_info/app_info.dart';
import 'package:base_flutter/core/theme/app_theme.dart';
import 'package:base_flutter/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class App extends StatefulWidget {
  const App({required this.initialSettings, super.key});

  final AppSettings initialSettings;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = createRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: getIt<AppInfo>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<SettingsCubit>(param1: widget.initialSettings),
          ),
          BlocProvider(create: (_) => getIt<NotificationsCubit>()),
        ],
        child: BlocConsumer<SettingsCubit, AppSettings>(
          listenWhen: (previous, current) =>
              previous.languageCode != current.languageCode,
          listener: (_, settings) async {
            final code = settings.languageCode;
            if (code != null) await LocaleSettings.setLocaleRaw(code);
          },
          builder: (context, settings) => MaterialApp.router(
            onGenerateTitle: (context) => context.t.app_name,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: switch (settings.themeMode) {
              AppThemeMode.system => ThemeMode.system,
              AppThemeMode.light => ThemeMode.light,
              AppThemeMode.dark => ThemeMode.dark,
            },
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            routerConfig: _router,
          ),
        ),
      ),
    );
  }
}
