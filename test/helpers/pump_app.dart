import 'package:base_flutter/core/theme/app_theme.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside the same shell the real app uses: translations,
  /// theme and localizations, plus any [providers] the widget needs
  /// (usually mocked cubits/blocs).
  Future<void> pumpApp(
    Widget widget, {
    List<BlocProvider> providers = const [],
    AppLocale locale = AppLocale.en,
  }) async {
    // Non-base locales are loaded lazily (deferred import), which needs
    // real async I/O outside the fake-async test zone.
    await runAsync(() => LocaleSettings.setLocale(locale));

    final app = MaterialApp(
      theme: AppTheme.light(),
      locale: locale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: widget,
    );

    await pumpWidget(
      TranslationProvider(
        child: providers.isEmpty
            ? app
            : MultiBlocProvider(providers: providers, child: app),
      ),
    );
  }
}
