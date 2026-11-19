# Base Flutter — Clean Architecture

Nhánh `clean-architecture`: base Flutter viết theo **Clean Architecture chia theo feature**, chạy song song với `main` (GetX).

## Tech stack

| Vai trò | Package |
|---|---|
| UI / theme | `material_ui`, `cupertino_ui`, `flex_color_scheme` 9 |
| State | `flutter_bloc` (Cubit mặc định, Bloc khi cần), `bloc_concurrency`, `stream_transform` |
| DI | `get_it` (đăng ký tay, mỗi feature tự đăng ký) |
| Routing | `go_router` (`StatefulShellRoute` cho bottom navigation) |
| Model | `freezed`, `json_serializable` |
| Network | `dio`, `retrofit` |
| Lưu trữ | `flutter_secure_storage` (token), `shared_preferences` (`SharedPreferencesAsync`) |
| Đa ngôn ngữ | `slang` (en, vi) |
| Log | `logger` |
| Test / lint | `bloc_test`, `mocktail`, `very_good_analysis` |

Flutter được ghim bằng fvm (`.fvmrc`), mọi lệnh bên dưới chạy qua `fvm`.

## Cấu trúc thư mục

```
lib/
├── main.dart                 # chỉ gọi bootstrap()
├── app/                      # lắp ráp ứng dụng
│   ├── bootstrap.dart        # khởi tạo trước runApp: env, DI, settings, locale
│   ├── app.dart              # MaterialApp.router + bloc dùng toàn app
│   ├── app_bloc_observer.dart
│   ├── di/injection.dart     # đăng ký core + gọi đăng ký của từng feature
│   └── router/               # routes, GoRouter, bottom navigation shell
├── core/                     # dùng chung, không biết gì về feature
│   ├── env/                  # AppEnv theo flavor
│   ├── error/                # Failure, Result, guard()
│   ├── network/              # tạo Dio, interceptor
│   ├── storage/              # TokenStorage (secure storage)
│   ├── l10n/                 # Failure → câu thông báo đã dịch
│   └── theme/ logger/ app_info/ widgets/
├── features/
│   └── <feature>/
│       ├── domain/           # entities, repositories (interface), usecases — Dart thuần
│       ├── data/             # models (DTO), datasources, repositories (impl)
│       ├── presentation/     # cubit/ bloc/ pages/ widgets/
│       └── <feature>_injection.dart
└── i18n/                     # en.json, vi.json + code sinh (gen/)
```

Các feature có sẵn: `posts` (danh sách + tìm kiếm), `notifications`, `settings` (theme, ngôn ngữ), `splash`.

## Quy tắc phụ thuộc

```
presentation ──▶ domain ◀── data
```

- `domain` không import Flutter, Dio, slang hay bất kỳ thứ gì của `data`/`presentation`.
- `data` cài đặt interface của `domain`; DTO đổi sang entity qua `toEntity()`.
- `presentation` chỉ gọi usecase, không gọi thẳng repository hay data source.
- Feature không import lẫn nhau. Thứ dùng chung thì đưa vào `core/`.
- Page không gọi `getIt`. Bloc/Cubit theo màn hình được tạo trong `app/router/app_router.dart`; bloc dùng toàn app được tạo trong `app/app.dart`.

## Luồng dữ liệu và xử lý lỗi

```
Page ─▶ Cubit/Bloc ─▶ UseCase ─▶ Repository (interface)
                                      ▲
                     RepositoryImpl ──┘ ─▶ DataSource (retrofit) ─▶ Dio
```

1. DataSource cứ để exception ném ra (`DioException`, lỗi parse…).
2. RepositoryImpl bọc mọi lời gọi bằng `guard(...)`, trả về `Result<T>`: `Ok(value)` hoặc `Err(failure)`. Không exception nào lọt ra khỏi tầng data.
3. `Failure` là sealed class (`NetworkFailure`, `TimeoutFailure`, `ServerFailure`, `UnauthorizedFailure`, `ParsingFailure`, …). Bloc/Cubit dùng `switch` bắt buộc xử lý đủ trường hợp.
4. Chỉ ở UI mới đổi `Failure` thành chữ: `failure.message(context.t)` (`core/l10n/failure_message.dart`).

## Cubit hay Bloc?

> Mặc định dùng **Cubit**. Chỉ dùng **Bloc** khi cần biến đổi luồng sự kiện (debounce, throttle, huỷ request cũ, xếp hàng) hoặc cần log chính xác hành động nào gây ra state. Một Cubit sau này cần chuyển sang Bloc thì phần UI hầu như không phải sửa.

Ví dụ trong code:

- `PostsCubit`, `NotificationsCubit`, `SettingsCubit`: Cubit, UI gọi hàm trực tiếp.
- `PostSearchBloc`: Bloc, dùng `debounceRestartable()` để chờ người dùng gõ xong 350ms mới gọi API, và bỏ kết quả của lần tìm cũ nếu có lần mới.

## Thêm một feature mới

1. Tạo `lib/features/<tên>/` với 3 tầng `domain/`, `data/`, `presentation/`.
2. **domain**: entity (`@freezed`), interface repository trả `Future<Result<T>>`, mỗi usecase một class có `call(...)`.
3. **data**: DTO (`@freezed` + `fromJson` + `toEntity()`), data source (retrofit `@RestApi()`), `RepositoryImpl` bọc bằng `guard()`.
4. **presentation**: Cubit/Bloc + state (`@freezed` sealed), page dùng `BlocBuilder` + `switch`.
5. Tạo `<tên>_injection.dart` với hàm `register<Tên>Feature(GetIt getIt)` và gọi nó trong `app/di/injection.dart`.
6. Thêm route trong `app/router/routes.dart` + `app_router.dart` (tạo Bloc/Cubit ngay tại route).
7. Thêm chuỗi vào `lib/i18n/en.json` và `vi.json`.
8. Chạy sinh code, viết test cho repository và Cubit/Bloc.

## Chạy app

```bash
fvm flutter run --flavor dev
```

Môi trường xác định **chỉ bằng `--flavor`** (`dev` / `stag` / `prod`). Xem chi tiết và cách truyền secret trong [FLAVORS.md](FLAVORS.md).

## Sinh code

```bash
fvm dart run build_runner build
```

```bash
fvm dart run slang
```

`build_runner` sinh code cho freezed, json_serializable và retrofit. `slang` sinh code đa ngôn ngữ từ `lib/i18n/*.json` (cấu hình trong `slang.yaml`).

## Test và lint

```bash
fvm flutter test
```

```bash
fvm flutter analyze
```

Test nằm trong `test/`, theo đúng cấu trúc của `lib/`: map lỗi (`guard`), repository, Cubit/Bloc (kể cả debounce của tìm kiếm) và feature notifications chạy từ đầu đến cuối.

Lint dùng `very_good_analysis`, tắt 3 rule trong `analysis_options.yaml` (có ghi lý do): `public_member_api_docs`, `sort_pub_dependencies`, `unnecessary_type_name_in_constructor`.
