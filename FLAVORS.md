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

### Option 1: Sử dụng script (Recommended)
```bash
# Development
./scripts/run_dev.sh

# Staging
./scripts/run_stag.sh

# Production
./scripts/run_prod.sh
```

### Option 2: Sử dụng Flutter command
```bash
# Development
flutter run --flavor dev --dart-define=FLAVOR=dev

# Staging
flutter run --flavor stag --dart-define=FLAVOR=stag

# Production
flutter run --flavor prod --dart-define=FLAVOR=prod
```

### Option 3: Build APK/IPA
```bash
# Development APK
flutter build apk --flavor dev --dart-define=FLAVOR=dev

# Staging APK
flutter build apk --flavor stag --dart-define=FLAVOR=stag

# Production APK
flutter build apk --flavor prod --dart-define=FLAVOR=prod
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

Để setup flavors cho iOS, cần cấu hình schemes trong Xcode:
1. Mở project trong Xcode
2. Tạo schemes cho từng flavor
3. Set build configuration cho mỗi scheme

## Lưu ý

- File `.env.*` nên được thêm vào `.gitignore` nếu chứa sensitive data
- Tạo file `.env.example` để làm template
- Không commit API keys thật vào git



