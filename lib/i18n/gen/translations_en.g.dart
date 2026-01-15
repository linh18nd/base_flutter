///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEn({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final TranslationsEn _root = this; // ignore: unused_field

  @override
  TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

  // Translations
  @override
  String get app_name => 'Base Flutter';
  @override
  String get welcome => 'Welcome';
  @override
  String get home => 'Home';
  @override
  String get splash => 'Splash';
  @override
  String get counter => 'Counter';
  @override
  String get increment_counter => 'Increment Counter';
  @override
  String get theme_mode => 'Theme Mode';
  @override
  String get switch_to_light_mode => 'Switch to Light Mode';
  @override
  String get switch_to_dark_mode => 'Switch to Dark Mode';
  @override
  String get current => 'Current';
  @override
  String get toggle_theme => 'Toggle Theme';
  @override
  String get language => 'Language';
  @override
  String get english => 'English';
  @override
  String get vietnamese => 'Vietnamese';
  @override
  String get setting => 'Settings';
  @override
  String get notification => 'Notifications';
  @override
  String get dark_mode => 'Dark Mode';
  @override
  String get light_mode => 'Light Mode';
  @override
  String get app_info => 'App Information';
  @override
  String get app_version => 'Version 1.0.0';
  @override
  String get no_notifications => 'No notifications';
  @override
  String get clear_all => 'Clear All';
  @override
  String get load_posts => 'Load posts';
  @override
  String get no_posts_loaded => 'No posts loaded';
  @override
  String get failed_to_load_posts => 'Failed to load posts';
  @override
  String get error => 'Error';
  @override
  String get info => 'Info';
  @override
  String get retry => 'Retry';
  @override
  String get request_failed => 'Request failed';
  @override
  String get error_parsing_response => 'Error parsing response';
  @override
  String get an_error_occurred => 'An error occurred';
  @override
  String get connection_timeout => 'Connection timeout';
  @override
  String get server_error => 'Server error';
  @override
  String get request_cancelled => 'Request cancelled';
  @override
  String get connection_error => 'Connection error';
  @override
  String get no_internet_connection => 'No internet connection';
  @override
  String get welcome_message => 'Welcome to Base Flutter App';
  @override
  String get update_available => 'Update Available';
  @override
  String get update_available_message => 'A new version of the app is available';
}
