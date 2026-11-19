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
class TranslationsEn extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEn({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(
         cardinalResolver: cardinalResolver,
         ordinalResolver: ordinalResolver,
       );

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  late final TranslationsEn _root = this; // ignore: unused_field

  @override
  TranslationsEn $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsEn(meta: meta ?? this.$meta);

  // Translations
  @override
  String get app_name => 'Base Flutter';
  @override
  String get home => 'Home';
  @override
  String get notification => 'Notifications';
  @override
  String get setting => 'Settings';
  @override
  String get load_posts => 'Load posts';
  @override
  String get no_posts_loaded => 'No posts loaded';
  @override
  String get search => 'Search';
  @override
  String get search_hint => 'Search posts...';
  @override
  String get type_to_search => 'Type a keyword to search posts';
  @override
  String no_results({required Object query}) => 'No results for "${query}"';
  @override
  String get theme_mode => 'Theme mode';
  @override
  String get system_mode => 'System';
  @override
  String get light_mode => 'Light';
  @override
  String get dark_mode => 'Dark';
  @override
  String get language => 'Language';
  @override
  String get english => 'English';
  @override
  String get vietnamese => 'Vietnamese';
  @override
  String get app_info => 'App info';
  @override
  String app_version({required Object version, required Object build}) =>
      'Version ${version} (${build})';
  @override
  String get no_notifications => 'No notifications';
  @override
  String get clear_all => 'Clear all';
  @override
  String get welcome => 'Welcome';
  @override
  String get welcome_message => 'Welcome to the Base Flutter app';
  @override
  String get update_available => 'Update available';
  @override
  String get update_available_message =>
      'A new version of the app is available';
  @override
  String get retry => 'Retry';
  @override
  String get error_parsing_response => 'Error parsing response';
  @override
  String get an_error_occurred => 'An error occurred';
  @override
  String get connection_timeout => 'Connection timed out';
  @override
  String get server_error => 'Server error';
  @override
  String get request_cancelled => 'Request cancelled';
  @override
  String get connection_error => 'Connection error, please check your internet';
  @override
  String get unauthorized => 'Your session has expired';
  @override
  String get storage_error => 'Could not save data on this device';
}
