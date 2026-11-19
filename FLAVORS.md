# Flavor Configuration Guide

Project hỗ trợ 3 môi trường (flavor): **dev**, **stag**, **prod**.

## Cách hoạt động

- Môi trường được xác định **chỉ bằng `--flavor`**. Flutter tự gán hằng `appFlavor`: Android lấy từ `--flavor`, iOS lấy từ build configuration (`Debug-dev`, `Release-prod`…), nên build bằng CLI, CI, VS Code hay Xcode đều cho cùng kết quả.
- `lib/core/env/app_env.dart` đọc `appFlavor` và chọn cấu hình tương ứng (base URL, timeout). Các giá trị **không bí mật** này viết thẳng trong code, theo từng flavor.
- Không còn dùng file `.env` đóng gói vào app như trên `main`, nên bản build không chứa cấu hình của flavor khác.
- Thiếu `--flavor` thì app dùng `dev` và in cảnh báo ra log.

## Chạy app

```bash
fvm flutter run --flavor dev
```

```bash
fvm flutter run --flavor stag
```

```bash
fvm flutter run --flavor prod
```

VS Code: chọn cấu hình tương ứng trong `.vscode/launch.json` (Dev/Stag/Prod, debug hoặc release).

## Build

```bash
fvm flutter build apk --flavor prod
```

```bash
fvm flutter build appbundle --flavor prod
```

```bash
fvm flutter build ipa --flavor prod
```

## Secret (API key…)

Secret không commit vào git và không viết trong code. Truyền lúc build bằng `--dart-define-from-file`:

1. Copy `env/example.json` thành `env/<flavor>.json` (các file này đã được gitignore) rồi điền giá trị.
2. Thêm cờ khi chạy hoặc build:

```bash
fvm flutter run --flavor dev --dart-define-from-file=env/dev.json
```

| Key | Ý nghĩa |
|---|---|
| `API_KEY` | Gửi kèm header `X-API-Key` nếu có giá trị |
| `API_BASE_URL` | Ghi đè base URL mặc định của flavor (ví dụ trỏ sang máy local) |

Lưu ý: giá trị `--dart-define` vẫn nằm trong binary của app, nên chỉ dùng cho key phía client. Secret thật sự (khoá server, mật khẩu) không bao giờ được đưa vào app.

## Android

Flavor cấu hình trong `android/app/build.gradle.kts`:

- **dev**: applicationId thêm `.dev`, version thêm `-dev`
- **stag**: applicationId thêm `.stag`, version thêm `-stag`
- **prod**: không có hậu tố

## iOS

Mỗi flavor có scheme riêng (`dev`, `stag`, `prod`) và build configuration `Debug-<flavor>` / `Release-<flavor>`. Các file `ios/Flutter/<flavor>Debug.xcconfig` / `<flavor>Release.xcconfig` đặt bundle ID và tên hiển thị. Plugin native được quản lý bằng Swift Package Manager (không dùng CocoaPods).
