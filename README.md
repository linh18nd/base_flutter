# Base Flutter Project

Base structure cho Flutter project với GetX, Dio, SharedPreferences và JSON Annotation.

## Tech Stack

- **State Management**: GetX
- **Pages**: GetX Pages
- **Local Storage**: SharedPreferences
- **API Client**: Dio
- **JSON Parsing**: json_annotation

## Cấu trúc Project

```
lib/
├── bindings/          # GetX bindings
│   └── initial_binding.dart
├── core/              # Core functionality
│   ├── config/        # App configuration
│   ├── constants/     # Constants
│   ├── network/       # API client & services
│   ├── storage/       # Local storage service
│   └── utils/         # Utilities
├── data/              # Data layer
│   ├── models/        # Data models với json_annotation
│   └── repositories/  # Data repositories
├── pages/             # GetX pages
│   ├── home/
│   └── splash/
├── routes/            # App routes
│   └── app_pages.dart
├── services/          # Business logic services
├── widgets/           # Reusable widgets
└── main.dart          # Entry point
```

## Cách sử dụng

### 1. Generate JSON Models

Sau khi tạo model với `@JsonSerializable()`, chạy lệnh:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Tạo Model mới

```dart
import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  final String name;
  final String email;

  UserModel({
    super.id,
    required this.name,
    required this.email,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
```

### 3. Tạo Service mới

```dart
import 'package:get/get.dart';
import '../core/network/api_client.dart';
import '../core/network/api_response.dart';
import '../core/network/api_service.dart';

class UserService extends ApiService {
  UserService(ApiClient apiClient) : super(apiClient);

  Future<ApiResponse<UserModel>> getUser(int id) async {
    try {
      final response = await apiClient.get('/users/$id');
      return handleResponse<UserModel>(
        response,
        (data) => UserModel.fromJson(data),
      );
    } catch (e) {
      return handleError<UserModel>(e);
    }
  }
}
```

### 4. Tạo Controller mới

```dart
import 'package:get/get.dart';
import '../services/user_service.dart';
import '../data/models/user_model.dart';

class UserController extends GetxController {
  final UserService _userService = Get.find();
  final user = Rx<UserModel?>(null);
  final isLoading = false.obs;

  Future<void> fetchUser(int id) async {
    isLoading.value = true;
    final response = await _userService.getUser(id);
    if (response.success && response.data != null) {
      user.value = response.data;
    } else {
      Get.snackbar('Error', response.message ?? 'Failed to load user');
    }
    isLoading.value = false;
  }
}
```

### 5. Sử dụng Storage Service

```dart
final storageService = Get.find<StorageService>();

// Lưu dữ liệu
await storageService.setString('key', 'value');
await storageService.setBool('isLoggedIn', true);

// Đọc dữ liệu
final value = storageService.getString('key');
final isLoggedIn = storageService.getBool('isLoggedIn');
```

### 6. Thêm Route mới

Trong `lib/routes/app_pages.dart`:

```dart
GetPage(
  name: Routes.user,
  page: () => const UserPage(),
  binding: UserBinding(),
),
```

## Configuration

### Environment Files

Project sử dụng file `.env` để quản lý cấu hình cho từng môi trường. Tạo 3 file trong root directory:

**.env.dev** (Development):
```env
ENV=dev
API_BASE_URL=https://api-dev.example.com
API_KEY=dev_api_key_12345
API_TIMEOUT=30
APP_NAME=Base Flutter Dev
APP_VERSION=1.0.0
```

**.env.stag** (Staging):
```env
ENV=stag
API_BASE_URL=https://api-stag.example.com
API_KEY=stag_api_key_67890
API_TIMEOUT=30
APP_NAME=Base Flutter Stag
APP_VERSION=1.0.0
```

**.env.prod** (Production):
```env
ENV=prod
API_BASE_URL=https://api.example.com
API_KEY=prod_api_key_abcdef
API_TIMEOUT=30
APP_NAME=Base Flutter
APP_VERSION=1.0.0
```

### Sử dụng Configuration trong Code

Tất cả cấu hình được load tự động từ env files thông qua `AppConfig`:

```dart
import 'package:base_flutter/core/config/app_config.dart';

// Get API base URL
String apiUrl = AppConfig.baseUrl;

// Get API Key
String apiKey = AppConfig.apiKey;

// Get App Name
String appName = AppConfig.appName;

// Check environment
if (AppConfig.isDev) {
  // Development only code
}

if (AppConfig.isProd) {
  // Production only code
}
```

### API Client Configuration

API Client tự động sử dụng cấu hình từ env:

- **Base URL**: Load từ `API_BASE_URL` trong env file
- **API Key**: Tự động thêm vào headers nếu có
- **Timeout**: Load từ `API_TIMEOUT` (mặc định 30 giây)
- **Headers**: Tự động thêm Authorization token và Language header

### Thêm Environment Variables mới

1. Thêm variable vào các file `.env.*`:
```env
CUSTOM_KEY=custom_value
```

2. Sử dụng trong code:
```dart
import 'package:base_flutter/core/config/env_service.dart';

String? customValue = EnvService.getEnv('CUSTOM_KEY');
```

### Lưu ý

- File `.env.*` nên được thêm vào `.gitignore` nếu chứa sensitive data
- Tạo file `.env.example` để làm template cho team
- Không commit API keys thật vào git repository

## Dependencies

Xem `pubspec.yaml` để biết danh sách đầy đủ các dependencies.

## Build Release

### Android APK

```bash
# Development
flutter build apk --flavor dev --release

# Staging
flutter build apk --flavor stag --release

# Production
flutter build apk --flavor prod --release
```

### Android AppBundle

```bash
# Development
flutter build appbundle --flavor dev --release

# Staging
flutter build appbundle --flavor stag --release

# Production
flutter build appbundle --flavor prod --release
```

### iOS

```bash
# Development
flutter build ios --flavor dev --release

# Staging
flutter build ios --flavor stag --release

# Production
flutter build ios --flavor prod --release
```

## Getting Started

1. Clone project
2. Chạy `flutter pub get`
3. Tạo các file `.env.dev`, `.env.stag`, `.env.prod` với cấu hình tương ứng
4. Chạy `flutter pub run build_runner build --delete-conflicting-outputs` để generate JSON models
5. Cập nhật các file `.env.*` với API URL và keys của bạn
6. Bắt đầu phát triển!
