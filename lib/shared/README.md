# shared/

Nghiệp vụ dùng chung cho **nhiều feature**: entity, repository, usecase mà từ hai feature trở lên cùng cần (ví dụ `User` dùng ở profile, đơn hàng, chat; giỏ hàng dùng ở danh sách sản phẩm và thanh toán).

```
app ──▶ features ──▶ shared ──▶ core
```

- Feature được import `shared/`; `shared/` **không** import feature hay `app/`.
- Mỗi module chỉ có `domain/` + `data/` (không có màn hình). Màn hình nằm ở các feature dùng module đó.
- `core/` là hạ tầng kỹ thuật (Dio, lỗi, theme…), **không** chứa nghiệp vụ. Nghiệp vụ dùng chung đặt ở đây.

Tạo module mới:

```bash
make shared name=users entity=user
```

Chỉ chuyển code lên đây khi **feature thứ hai** thật sự cần tới. Thứ gì một feature dùng thì để trong feature đó.

Các quy tắc trên được kiểm tra tự động bởi `test/architecture/architecture_test.dart`.
