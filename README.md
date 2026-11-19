# Base Flutter — Clean Architecture

Nhánh `clean-architecture`: base Flutter viết theo **Clean Architecture chia theo feature**, chạy song song với `main` (GetX).

## Bắt đầu nhanh

Cần cài sẵn [fvm](https://fvm.app), Xcode (iOS) và Android Studio (Android).

```bash
make setup
```

```bash
make run
```

`make setup` cài đúng bản Flutter ghim trong `.fvmrc`, tải package, cài `mason_cli` và sinh code. `make run` chạy flavor `dev` (đổi bằng `make run FLAVOR=stag`).

Mở bằng VS Code: cài các extension được gợi ý, chọn cấu hình chạy trong tab Run and Debug.

## Lệnh thường dùng

| Lệnh | Việc |
|---|---|
| `make setup` | Cài đặt lần đầu |
| `make run [FLAVOR=dev\|stag\|prod]` | Chạy app (tự kèm `env/<flavor>.json` nếu có) |
| `make gen` / `make watch` | Sinh code (slang + build_runner), một lần / theo dõi liên tục |
| `make feature name=orders entity=order` | Sinh một feature mới đủ 3 tầng + test |
| `make shared name=users entity=user` | Sinh một module nghiệp vụ dùng chung trong `lib/shared/` |
| `make check` | Kiểm tra format, analyze, test, nên chạy trước khi commit |
| `make test` / `make analyze` / `make format` | Chạy riêng từng bước |

Gõ `make` để xem toàn bộ danh sách. Không dùng `make` được (Windows) thì mở `Makefile`, mỗi lệnh chỉ là vài dòng `fvm flutter …` / `fvm dart …`.

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
| Sinh code feature | `mason` (brick `feature` trong `bricks/`) |

## Cấu trúc thư mục

```
lib/
├── main.dart                 # chỉ gọi bootstrap()
├── app/                      # lắp ráp ứng dụng
│   ├── bootstrap.dart        # khởi tạo trước runApp: env, DI, settings, locale
│   ├── app.dart              # MaterialApp.router + bloc dùng toàn app
│   ├── app_bloc_observer.dart
│   ├── di/injection.dart     # đăng ký core + gọi đăng ký của từng feature
│   ├── router/               # routes, GoRouter, bottom navigation shell
│   └── splash/               # màn hình mở đầu
├── core/                     # hạ tầng kỹ thuật dùng chung, không chứa nghiệp vụ
│   ├── env/                  # AppEnv theo flavor
│   ├── error/                # Failure, Result, guard() / guardStorage()
│   ├── network/              # tạo Dio, interceptor
│   ├── storage/              # TokenStorage (secure storage)
│   ├── pagination/           # PagedState, PaginatedCubit (danh sách cuộn vô hạn)
│   ├── l10n/                 # Failure → câu thông báo đã dịch
│   └── theme/ logger/ app_info/ widgets/   # widgets/ có PagedListView
├── shared/                   # nghiệp vụ dùng chung cho nhiều feature (domain + data)
├── features/
│   └── <feature>/
│       ├── domain/           # entities/ repositories/ usecases/ — không phụ thuộc Flutter
│       ├── data/             # models/ datasources/ repositories/
│       ├── presentation/     # cubit/ hoặc bloc/, pages/, widgets/
│       └── <feature>_injection.dart
└── i18n/                     # en.json, vi.json + code sinh (gen/)

test/                         # cùng cấu trúc với lib/
├── architecture/             # test tự kiểm tra quy tắc import giữa các tầng
├── helpers/pump_app.dart     # dựng sẵn l10n, theme, providers cho widget test
├── core/
└── features/<feature>/{data,presentation}/

bricks/feature/               # template Mason cho `make feature`
bricks/shared/                # template Mason cho `make shared`
env/example.json              # mẫu file secret theo flavor
```

Các feature có sẵn làm ví dụ: `posts` (danh sách phân trang + tìm kiếm), `notifications`, `settings` (theme, ngôn ngữ).

## Quy tắc phụ thuộc

Giữa các thư mục lớn:

```
app ──▶ features ──▶ shared ──▶ core
```

Bên trong mỗi feature hoặc module shared:

```
presentation ──▶ domain ◀── data
```

- `core/` chỉ import `core/` (và `i18n/`). `shared/` chỉ import `core/` và `shared/`. Feature import được `core/`, `shared/` và `app/router/routes.dart` (để điều hướng), **không** import feature khác.
- `domain` không import Flutter, Dio, slang hay bất kỳ thứ gì của `data`/`presentation`. Ngoại lệ duy nhất là `freezed_annotation` (package Dart thuần) để entity bất biến và có `copyWith`.
- `data` cài đặt interface của `domain`; DTO/model đổi sang entity qua `toEntity()`. Data source không dùng thẳng entity.
- `presentation` chỉ gọi usecase, không gọi thẳng repository hay data source.
- Feature không import lẫn nhau. Nghiệp vụ dùng chung đưa vào `shared/`, hạ tầng kỹ thuật đưa vào `core/` (xem mục "Logic dùng chung" bên dưới).
- Các quy tắc này được **kiểm tra tự động** bởi `test/architecture/architecture_test.dart` (chạy trong `make test` / `make check`). Import sai chỗ sẽ làm test fail kèm thông báo cách sửa.
- Page không gọi `getIt`. Bloc/Cubit theo màn hình được tạo trong `app/router/app_router.dart`; bloc dùng toàn app được tạo trong `app/app.dart`.

## Quy ước

| Thứ | Quy ước | Ví dụ |
|---|---|---|
| Thư mục feature | snake_case, số nhiều | `features/posts/` |
| Entity | Danh từ số ít, `@freezed` | `Post` → `post.dart` |
| DTO / Model | Dữ liệu từ API: `<Entity>Dto`; dữ liệu lưu local: `<Entity>Model`. Cả hai có `fromJson` + `toEntity()` | `PostDto`, `NotificationModel` |
| Repository | Interface `<Entity>Repository`, cài đặt `<Entity>RepositoryImpl`. Hàm có thể lỗi trả `Future<Result<T>>`; riêng hàm theo dõi dữ liệu (`watch…`) trả `Stream` | `PostRepository`, `NotificationRepository` |
| Usecase | **Mỗi usecase một file**, tên là động từ, gọi bằng `call()`. Được phép chỉ chuyển tiếp một dòng sang repository; khi có logic nghiệp vụ thì đặt vào đây, không viết logic giả cho đủ | `GetPosts` → `get_posts.dart` |
| Cubit / Bloc | `<Feature>Cubit` / `<Tên>Bloc`, **state (và event) tách file riêng bằng `part`** | `posts_cubit.dart` + `posts_state.dart` |
| State | `@freezed sealed` với các trạng thái `initial / loading / loaded / failure` | `PostsState.loaded(posts)` |
| Test | Cùng đường dẫn với file được test, thêm `_test` | `test/features/posts/presentation/posts_cubit_test.dart` |

## Luồng dữ liệu và xử lý lỗi

```
Page ─▶ Cubit/Bloc ─▶ UseCase ─▶ Repository (interface)
                                      ▲
                     RepositoryImpl ──┘ ─▶ DataSource (retrofit) ─▶ Dio
```

1. DataSource cứ để exception ném ra (`DioException`, lỗi parse…).
2. RepositoryImpl bọc mọi lời gọi và trả về `Result<T>`: `Ok(value)` hoặc `Err(failure)`. Không exception nào lọt ra khỏi tầng data. Dùng helper theo loại nguồn dữ liệu (đều nằm trong `core/error/guard.dart`):
   - `guard(...)` cho gọi API (Dio/retrofit): đổi lỗi mạng, timeout, mã HTTP, lỗi parse thành `Failure` tương ứng.
   - `guardStorage(...)` cho đọc/ghi local (shared preferences, secure storage, database, bộ nhớ): mọi lỗi thành `StorageFailure`.
3. `Failure` là sealed class (`NetworkFailure`, `TimeoutFailure`, `ServerFailure`, `UnauthorizedFailure`, `ParsingFailure`, …). Bloc/Cubit dùng `switch` bắt buộc xử lý đủ trường hợp.
4. Chỉ ở UI mới đổi `Failure` thành chữ: `failure.message(context.t)` (`core/l10n/failure_message.dart`).

## Cubit hay Bloc?

> Mặc định dùng **Cubit**. Chỉ dùng **Bloc** khi cần biến đổi luồng sự kiện (debounce, throttle, huỷ request cũ, xếp hàng) hoặc cần log chính xác hành động nào gây ra state. Một Cubit sau này cần chuyển sang Bloc thì phần UI hầu như không phải sửa.

Ví dụ trong code:

- `PostsCubit` (kế thừa `PaginatedCubit`), `NotificationsCubit`, `SettingsCubit`: Cubit, UI gọi hàm trực tiếp.
- `PostSearchBloc`: Bloc, dùng `debounceRestartable()` để chờ người dùng gõ xong 350ms mới gọi API, và bỏ kết quả của lần tìm cũ nếu có lần mới.

## Logic dùng chung giữa nhiều màn

| Tình huống | Đặt ở đâu | Ví dụ trong base |
|---|---|---|
| Nhiều màn **trong cùng một feature** (danh sách, chi tiết, sửa) | Chung feature, dùng chung repository/usecase, **mỗi màn một Cubit**. Luồng nhiều bước cần chung một state thì tạo Cubit ở route cha (`ShellRoute`) | `posts`: `PostsPage` + `PostSearchPage` dùng chung `PostRepository` |
| **State thay đổi** mà nhiều feature cùng đọc (user đăng nhập, giỏ hàng, badge) | **Cubit cấp app** tạo trong `app/app.dart`; dữ liệu lấy từ repository phát `Stream` làm nguồn duy nhất | `NotificationsCubit` dùng cho cả tab Thông báo và badge ở bottom nav; `SettingsCubit` cho theme và ngôn ngữ |
| **Nghiệp vụ** (entity, repository, usecase) mà từ hai feature trở lên cần | Module trong `lib/shared/<tên>/` (chỉ `domain/` + `data/`), tạo bằng `make shared` | Xem `lib/shared/README.md` |
| **Logic giao diện** lặp lại (phân trang, widget trạng thái) | `core/` | `PaginatedCubit` + `PagedListView` (danh sách cuộn vô hạn), `LoadingView` / `FailureView` / `MessageView` |

Hai nguyên tắc:

- Chỉ chuyển code lên `shared/` khi **feature thứ hai** thật sự cần. Thứ gì một feature dùng thì để trong feature đó.
- `core/` chỉ chứa thứ **không mang nghiệp vụ** (dùng được ở bất kỳ app nào). Nghiệp vụ của app này đặt ở `shared/`.

### Danh sách phân trang

Màn danh sách có cuộn vô hạn chỉ cần kế thừa `PaginatedCubit` và viết một hàm tải một trang. Tải lần đầu, kéo để tải lại, tải thêm khi cuộn gần cuối, hết dữ liệu và lỗi đều đã được xử lý sẵn:

```dart
class OrdersCubit extends PaginatedCubit<Order> {
  OrdersCubit(this._getOrders);
  final GetOrders _getOrders;

  @override
  Future<Result<List<Order>>> fetchPage(int page) =>
      _getOrders(page: page, limit: pageSize);
}
```

Phía UI dùng `PagedListView` với state `PagedState<Order>`. Ví dụ đầy đủ ở `features/posts/presentation/`.

## Thêm một feature mới

```bash
make feature name=orders entity=order
```

Lệnh này sinh 12 file theo đúng quy ước ở trên: entity, DTO, retrofit data source, repository, usecase `GetOrders`, `OrdersCubit` + state, `OrdersPage`, `orders_injection.dart`, kèm test cho repository và cubit. Sau đó tự chạy sinh code và format. Code sinh ra analyze sạch và test pass ngay.

Còn 3 việc làm tay (lệnh in ra sau khi chạy xong):

1. Gọi `registerOrdersFeature(getIt)` trong `lib/app/di/injection.dart`.
2. Thêm route trong `lib/app/router/routes.dart` và `app_router.dart`, tạo Cubit ngay tại route:
   ```dart
   GoRoute(
     path: Routes.orders,
     builder: (_, _) => BlocProvider(
       create: (_) => getIt<OrdersCubit>(),
       child: const OrdersPage(),
     ),
   ),
   ```
3. Thay field mẫu (`id`, `title`), endpoint và tiêu đề trang ở các chỗ đánh dấu `TODO(team)`, thêm chuỗi dịch vào `lib/i18n/*.json`.

Muốn sửa template thì sửa trong `bricks/feature/__brick__/`.

## Viết test

- Unit test cho repository (mock data source) và Cubit/Bloc (`blocTest`): xem `test/features/posts/`.
- Widget test: dùng `tester.pumpApp(widget, providers: [...])` trong `test/helpers/pump_app.dart` với Cubit được mock bằng `MockCubit`. Xem `test/features/posts/presentation/posts_page_test.dart`.
- Test kiến trúc (`test/architecture/`) quét toàn bộ import trong `lib/` theo quy tắc phụ thuộc. Không cần sửa khi thêm feature; chỉ sửa `import_rules.dart` khi team đổi quy tắc.

## Chạy app và flavor

Môi trường xác định **chỉ bằng `--flavor`** (`dev` / `stag` / `prod`). Xem chi tiết và cách truyền secret trong [FLAVORS.md](FLAVORS.md).

## Lint

`very_good_analysis`, tắt 3 rule trong `analysis_options.yaml` (có ghi lý do): `public_member_api_docs`, `sort_pub_dependencies`, `unnecessary_type_name_in_constructor`.
