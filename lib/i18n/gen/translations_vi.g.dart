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
  /// vi: 'Chào mừng'
  String get welcome => 'Chào mừng';

  /// en: 'Home'
  ///
  /// vi: 'Trang chủ'
  String get home => 'Trang chủ';

  /// en: 'Splash'
  ///
  /// vi: 'Màn hình khởi động'
  String get splash => 'Màn hình khởi động';

  /// en: 'Counter'
  ///
  /// vi: 'Bộ đếm'
  String get counter => 'Bộ đếm';

  /// en: 'Increment Counter'
  ///
  /// vi: 'Tăng bộ đếm'
  String get increment_counter => 'Tăng bộ đếm';

  /// en: 'Theme Mode'
  ///
  /// vi: 'Chế độ giao diện'
  String get theme_mode => 'Chế độ giao diện';

  /// en: 'Switch to Light Mode'
  ///
  /// vi: 'Chuyển sang chế độ sáng'
  String get switch_to_light_mode => 'Chuyển sang chế độ sáng';

  /// en: 'Switch to Dark Mode'
  ///
  /// vi: 'Chuyển sang chế độ tối'
  String get switch_to_dark_mode => 'Chuyển sang chế độ tối';

  /// en: 'Current'
  ///
  /// vi: 'Hiện tại'
  String get current => 'Hiện tại';

  /// en: 'Toggle Theme'
  ///
  /// vi: 'Chuyển đổi giao diện'
  String get toggle_theme => 'Chuyển đổi giao diện';

  /// en: 'Language'
  ///
  /// vi: 'Ngôn ngữ'
  String get language => 'Ngôn ngữ';

  /// en: 'English'
  ///
  /// vi: 'Tiếng Anh'
  String get english => 'Tiếng Anh';

  /// en: 'Vietnamese'
  ///
  /// vi: 'Tiếng Việt'
  String get vietnamese => 'Tiếng Việt';

  /// en: 'Settings'
  ///
  /// vi: 'Cài đặt'
  String get setting => 'Cài đặt';

  /// en: 'Notifications'
  ///
  /// vi: 'Thông báo'
  String get notification => 'Thông báo';

  /// en: 'Dark Mode'
  ///
  /// vi: 'Chế độ tối'
  String get dark_mode => 'Chế độ tối';

  /// en: 'Light Mode'
  ///
  /// vi: 'Chế độ sáng'
  String get light_mode => 'Chế độ sáng';

  /// en: 'App Information'
  ///
  /// vi: 'Thông tin ứng dụng'
  String get app_info => 'Thông tin ứng dụng';

  /// en: 'Version 1.0.0'
  ///
  /// vi: 'Phiên bản 1.0.0'
  String get app_version => 'Phiên bản 1.0.0';

  /// en: 'No notifications'
  ///
  /// vi: 'Không có thông báo'
  String get no_notifications => 'Không có thông báo';

  /// en: 'Clear All'
  ///
  /// vi: 'Xóa tất cả'
  String get clear_all => 'Xóa tất cả';

  /// en: 'Load posts'
  ///
  /// vi: 'Tải bài viết'
  String get load_posts => 'Tải bài viết';

  /// en: 'No posts loaded'
  ///
  /// vi: 'Chưa có bài viết nào'
  String get no_posts_loaded => 'Chưa có bài viết nào';

  /// en: 'Failed to load posts'
  ///
  /// vi: 'Không thể tải bài viết'
  String get failed_to_load_posts => 'Không thể tải bài viết';

  /// en: 'Error'
  ///
  /// vi: 'Lỗi'
  String get error => 'Lỗi';

  /// en: 'Info'
  ///
  /// vi: 'Thông tin'
  String get info => 'Thông tin';

  /// en: 'Retry'
  ///
  /// vi: 'Thử lại'
  String get retry => 'Thử lại';

  /// en: 'Request failed'
  ///
  /// vi: 'Yêu cầu thất bại'
  String get request_failed => 'Yêu cầu thất bại';

  /// en: 'Error parsing response'
  ///
  /// vi: 'Lỗi phân tích phản hồi'
  String get error_parsing_response => 'Lỗi phân tích phản hồi';

  /// en: 'An error occurred'
  ///
  /// vi: 'Đã xảy ra lỗi'
  String get an_error_occurred => 'Đã xảy ra lỗi';

  /// en: 'Connection timeout'
  ///
  /// vi: 'Hết thời gian kết nối'
  String get connection_timeout => 'Hết thời gian kết nối';

  /// en: 'Server error'
  ///
  /// vi: 'Lỗi máy chủ'
  String get server_error => 'Lỗi máy chủ';

  /// en: 'Request cancelled'
  ///
  /// vi: 'Yêu cầu đã bị hủy'
  String get request_cancelled => 'Yêu cầu đã bị hủy';

  /// en: 'Connection error'
  ///
  /// vi: 'Lỗi kết nối'
  String get connection_error => 'Lỗi kết nối';

  /// en: 'No internet connection'
  ///
  /// vi: 'Không có kết nối internet'
  String get no_internet_connection => 'Không có kết nối internet';

  /// en: 'Welcome to Base Flutter App'
  ///
  /// vi: 'Chào mừng đến với ứng dụng Base Flutter'
  String get welcome_message => 'Chào mừng đến với ứng dụng Base Flutter';

  /// en: 'Update Available'
  ///
  /// vi: 'Có bản cập nhật'
  String get update_available => 'Có bản cập nhật';

  /// en: 'A new version of the app is available'
  ///
  /// vi: 'Đã có phiên bản mới của ứng dụng'
  String get update_available_message => 'Đã có phiên bản mới của ứng dụng';
}
