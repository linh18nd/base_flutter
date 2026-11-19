# Flavor Configuration Guide

Project này hỗ trợ 3 môi trường (flavors): **dev**, **stag**, và **prod**.

## Cấu trúc

### Environment Files
Tạo các file `.env` trong root directory:

- `.env.dev` - Development environment
- `.env.stag` - Staging environment  
- `.env.prod` - Production environment

### Format của file .env:
```env
ENV=dev
API_BASE_URL=https://api-dev.example.com
API_KEY=dev_api_key_12345
API_TIMEOUT=30
APP_NAME=Base Flutter Dev
APP_VERSION=1.0.0
```

## Cách chạy

Môi trường được xác định **chỉ bằng `--flavor`**: Flutter tự gán hằng `appFlavor` (Android lấy từ `--flavor`, iOS lấy từ build configuration như `Debug-dev`), `FlavorConfig` đọc hằng này để nạp đúng file `.env.*`. Không cần (và không còn dùng) `--dart-define=FLAVOR=...`. Thiếu `--flavor` thì app rơi về `dev` và in cảnh báo.

### Chạy app
```bash
fvm flutter run --flavor dev
fvm flutter run --flavor stag
fvm flutter run --flavor prod
```

VS Code: chọn cấu hình tương ứng trong `.vscode/launch.json` (Dev/Stag/Prod, debug hoặc release).

### Build
```bash
fvm flutter build apk --flavor prod
fvm flutter build appbundle --flavor prod
fvm flutter build ipa --flavor prod
```

## Sử dụng trong code

### Truy cập environment variables:
```dart
import 'package:base_flutter/core/config/env_service.dart';
import 'package:base_flutter/core/config/app_config.dart';

// Get API base URL
String apiUrl = AppConfig.baseUrl;

// Get API Key
String apiKey = AppConfig.apiKey;

// Check environment
if (AppConfig.isDev) {
  // Development only code
}

if (AppConfig.isProd) {
  // Production only code
}
```

### Truy cập trực tiếp từ EnvService:
```dart
import 'package:base_flutter/core/config/env_service.dart';

String? customValue = EnvService.getEnv('CUSTOM_KEY');
```

## Android Configuration

Flavors đã được cấu hình trong `android/app/build.gradle.kts`:

- **dev**: Application ID suffix `.dev`, version suffix `-dev`
- **stag**: Application ID suffix `.stag`, version suffix `-stag`
- **prod**: No suffix (production)

## iOS Configuration

Đã cấu hình sẵn trong Xcode: mỗi flavor có scheme riêng (`dev`, `stag`, `prod`) và build configuration `Debug-<flavor>` / `Release-<flavor>`, dùng file `ios/Flutter/<flavor>Debug.xcconfig` / `<flavor>Release.xcconfig` để đặt bundle ID và tên hiển thị. Build thẳng từ Xcode bằng scheme tương ứng cũng nạp đúng môi trường.

## Lưu ý

- File `.env.*` nên được thêm vào `.gitignore` nếu chứa sensitive data
- Tạo file `.env.example` để làm template
- Không commit API keys thật vào git



