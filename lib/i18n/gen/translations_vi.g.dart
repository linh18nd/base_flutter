///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsVi = Translations; // ignore: unused_element

class Translations with BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.vi,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <vi>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

  // Translations

  /// en: 'Base Flutter'
  ///
  /// vi: 'Base Flutter'
  String get app_name => 'Base Flutter';

  /// en: 'Welcome'
  ///
  String get welcome => 'Chào mừng';

  /// en: 'Home'
  ///
  String get home => 'Trang chủ';

  /// en: 'Splash'
  ///
  String get splash => 'Màn hình khởi động';

  /// en: 'Counter'
  ///
  String get counter => 'Bộ đếm';

  /// en: 'Increment Counter'
  ///
  String get increment_counter => 'Tăng bộ đếm';

  /// en: 'Theme Mode'
  ///
  String get theme_mode => 'Chế độ giao diện';

  /// en: 'Switch to Light Mode'
  ///
  String get switch_to_light_mode => 'Chuyển sang chế độ sáng';

  /// en: 'Switch to Dark Mode'
  ///
  String get switch_to_dark_mode => 'Chuyển sang chế độ tối';

  /// en: 'Current'
  ///
  String get current => 'Hiện tại';

  /// en: 'Toggle Theme'
  ///
  String get toggle_theme => 'Chuyển đổi giao diện';

  /// en: 'Language'
  ///
  String get language => 'Ngôn ngữ';

  /// en: 'English'
  ///
  String get english => 'Tiếng Anh';

  /// en: 'Vietnamese'
  ///
  String get vietnamese => 'Tiếng Việt';

  /// en: 'Settings'
  ///
  String get setting => 'Cài đặt';

  /// en: 'Notifications'
  ///
  String get notification => 'Thông báo';

  /// en: 'Dark Mode'
  ///
  String get dark_mode => 'Chế độ tối';

  /// en: 'Light Mode'
  ///
  String get light_mode => 'Chế độ sáng';

  /// en: 'App Information'
  ///
  String get app_info => 'Thông tin ứng dụng';

  /// en: 'Version 1.0.0'
  ///
  String get app_version => 'Phiên bản 1.0.0';

  /// en: 'No notifications'
  ///
  String get no_notifications => 'Không có thông báo';

  /// en: 'Clear All'
  ///
  String get clear_all => 'Xóa tất cả';

  /// en: 'Load posts'
  ///
  String get load_posts => 'Tải bài viết';

  /// en: 'No posts loaded'
  ///
  String get no_posts_loaded => 'Chưa có bài viết nào';

  /// en: 'Failed to load posts'
  ///
  String get failed_to_load_posts => 'Không thể tải bài viết';

  /// en: 'Error'
  ///
  String get error => 'Lỗi';

  /// en: 'Info'
  ///
  String get info => 'Thông tin';

  /// en: 'Retry'
  ///
  String get retry => 'Thử lại';

  /// en: 'Request failed'
  ///
  String get request_failed => 'Yêu cầu thất bại';

  /// en: 'Error parsing response'
  ///
  String get error_parsing_response => 'Lỗi phân tích phản hồi';

  /// en: 'An error occurred'
  ///
  String get an_error_occurred => 'Đã xảy ra lỗi';

  /// en: 'Connection timeout'
  ///
  String get connection_timeout => 'Hết thời gian kết nối';

  /// en: 'Server error'
  ///
  String get server_error => 'Lỗi máy chủ';

  /// en: 'Request cancelled'
  ///
  String get request_cancelled => 'Yêu cầu đã bị hủy';

  /// en: 'Connection error'
  ///
  String get connection_error => 'Lỗi kết nối';

  /// en: 'No internet connection'
  ///
  String get no_internet_connection => 'Không có kết nối internet';

  /// en: 'Welcome to Base Flutter App'
  ///
  String get welcome_message => 'Chào mừng đến với ứng dụng Base Flutter';

  /// en: 'Update Available'
  ///
  String get update_available => 'Có bản cập nhật';

  /// en: 'A new version of the app is available'
  ///
  String get update_available_message => 'Đã có phiên bản mới của ứng dụng';
}
