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
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.vi,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           );

  /// Metadata for the translations of <vi>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

  // Translations

  /// en: 'Base Flutter'
  ///
  /// vi: 'Base Flutter'
  String get app_name => 'Base Flutter';

  /// en: 'Home'
  ///
  /// vi: 'Trang chủ'
  String get home => 'Trang chủ';

  /// en: 'Notifications'
  ///
  /// vi: 'Thông báo'
  String get notification => 'Thông báo';

  /// en: 'Settings'
  ///
  /// vi: 'Cài đặt'
  String get setting => 'Cài đặt';

  /// en: 'Load posts'
  ///
  /// vi: 'Tải bài viết'
  String get load_posts => 'Tải bài viết';

  /// en: 'No posts loaded'
  ///
  /// vi: 'Chưa có bài viết nào'
  String get no_posts_loaded => 'Chưa có bài viết nào';

  /// en: 'Search'
  ///
  /// vi: 'Tìm kiếm'
  String get search => 'Tìm kiếm';

  /// en: 'Search posts...'
  ///
  /// vi: 'Tìm bài viết...'
  String get search_hint => 'Tìm bài viết...';

  /// en: 'Type a keyword to search posts'
  ///
  /// vi: 'Nhập từ khoá để tìm bài viết'
  String get type_to_search => 'Nhập từ khoá để tìm bài viết';

  /// en: 'No results for "{{query}}"'
  ///
  /// vi: 'Không tìm thấy kết quả cho "{{query}}"'
  String no_results({required Object query}) => 'Không tìm thấy kết quả cho "${query}"';

  /// en: 'Theme mode'
  ///
  /// vi: 'Chế độ giao diện'
  String get theme_mode => 'Chế độ giao diện';

  /// en: 'System'
  ///
  /// vi: 'Theo hệ thống'
  String get system_mode => 'Theo hệ thống';

  /// en: 'Light'
  ///
  /// vi: 'Chế độ sáng'
  String get light_mode => 'Chế độ sáng';

  /// en: 'Dark'
  ///
  /// vi: 'Chế độ tối'
  String get dark_mode => 'Chế độ tối';

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

  /// en: 'App info'
  ///
  /// vi: 'Thông tin ứng dụng'
  String get app_info => 'Thông tin ứng dụng';

  /// en: 'Version {{version}} ({{build}})'
  ///
  /// vi: 'Phiên bản {{version}} ({{build}})'
  String app_version({required Object version, required Object build}) => 'Phiên bản ${version} (${build})';

  /// en: 'No notifications'
  ///
  /// vi: 'Không có thông báo'
  String get no_notifications => 'Không có thông báo';

  /// en: 'Clear all'
  ///
  /// vi: 'Xóa tất cả'
  String get clear_all => 'Xóa tất cả';

  /// en: 'Welcome'
  ///
  /// vi: 'Chào mừng'
  String get welcome => 'Chào mừng';

  /// en: 'Welcome to the Base Flutter app'
  ///
  /// vi: 'Chào mừng đến với ứng dụng Base Flutter'
  String get welcome_message => 'Chào mừng đến với ứng dụng Base Flutter';

  /// en: 'Update available'
  ///
  /// vi: 'Có bản cập nhật'
  String get update_available => 'Có bản cập nhật';

  /// en: 'A new version of the app is available'
  ///
  /// vi: 'Đã có phiên bản mới của ứng dụng'
  String get update_available_message => 'Đã có phiên bản mới của ứng dụng';

  /// en: 'Retry'
  ///
  /// vi: 'Thử lại'
  String get retry => 'Thử lại';

  /// en: 'Error parsing response'
  ///
  /// vi: 'Lỗi phân tích phản hồi'
  String get error_parsing_response => 'Lỗi phân tích phản hồi';

  /// en: 'An error occurred'
  ///
  /// vi: 'Đã xảy ra lỗi'
  String get an_error_occurred => 'Đã xảy ra lỗi';

  /// en: 'Connection timed out'
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

  /// en: 'Connection error, please check your internet'
  ///
  /// vi: 'Lỗi kết nối, vui lòng kiểm tra internet'
  String get connection_error => 'Lỗi kết nối, vui lòng kiểm tra internet';

  /// en: 'Your session has expired'
  ///
  /// vi: 'Phiên đăng nhập đã hết hạn'
  String get unauthorized => 'Phiên đăng nhập đã hết hạn';

  /// en: 'Could not save data on this device'
  ///
  /// vi: 'Không thể lưu dữ liệu trên thiết bị'
  String get storage_error => 'Không thể lưu dữ liệu trên thiết bị';

  /// en: 'No data'
  ///
  /// vi: 'Không có dữ liệu'
  String get no_data => 'Không có dữ liệu';
}
