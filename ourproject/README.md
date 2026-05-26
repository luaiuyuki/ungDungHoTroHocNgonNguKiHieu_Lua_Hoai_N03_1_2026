# ourproject

A new Flutter project.

## Phân tích thiết kế Hướng đối tượng (OOP)

### 1. Tính Tổng quát hóa (Generalization) - Lớp `BaseScreen`
Trong dự án này, nhóm đã áp dụng tính chất **Tổng quát hóa (Generalization)** thông qua việc tạo ra lớp cơ sở `BaseScreen`.

**Phân tích kỹ thuật (`lib/screen/baseScreen.dart`):**
- **Lớp cha (`BaseScreen`):** Là một `abstract class` đóng vai trò là màn hình nền tảng. Lớp này định nghĩa sẵn một bộ khung giao diện chung (sử dụng `Scaffold`, `AppBar` được căn giữa).
- **Tính trừu tượng (Abstraction):** Buộc các lớp con khi kế thừa phải ghi đè và cung cấp chi tiết cho:
  - `title`: Tiêu đề cụ thể của màn hình.
  - `buildBody(BuildContext context)`: Nội dung (body) chuyên biệt của màn hình đó.
- **Lợi ích:** Áp dụng triệt để nguyên tắc DRY (Don't Repeat Yourself). Khi cần thay đổi thiết kế chung của toàn bộ ứng dụng (ví dụ: đổi màu AppBar, thêm nút Back mặc định), chỉ cần sửa tại `BaseScreen`.

**Nội dung áp dụng tương ứng với từng sinh viên:**
*Dựa trên việc chia sẻ công việc, các sinh viên sẽ áp dụng lớp `BaseScreen` này vào các màn hình cụ thể:*

- **Sinh viên Lụa:** 
  - Đảm nhiệm việc kế thừa `BaseScreen` cho các màn hình liên quan đến hệ thống và tài khoản người dùng (ví dụ: `LoginScreen`, `RegisterScreen`, `SettingsScreen`).
  - Lụa sẽ tái sử dụng cấu trúc AppBar chung này và chỉ tập trung phát triển logic giao diện bên trong phần `buildBody` (chứa các TextFields, Buttons, và xử lý logic xác thực).

- **Sinh viên Hoài:** 
  - Đảm nhiệm việc kế thừa `BaseScreen` cho các màn hình chức năng cốt lõi của ứng dụng (ví dụ: `DashboardScreen`, `DictionaryScreen`, `PracticeModesScreen`).
  - Hoài sẽ tái sử dụng bộ khung để hiển thị tiêu đề các bài học/thử thách, và tự thiết kế nội dung `buildBody` phức tạp hơn bao gồm các lưới (GridView) bài học, danh sách (ListView) từ vựng, và hiển thị tiến độ học tập.

**Trích lược code chính:**

*1. Mã nguồn lớp BaseScreen (Lớp Tổng quát hóa):*
```dart
abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  /// Thuộc tính trừu tượng: Yêu cầu lớp con bắt buộc cung cấp tiêu đề riêng
  String get title;

  /// Phương thức trừu tượng: Yêu cầu lớp con tự thiết kế nội dung riêng
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: buildBody(context), // Gọi đến phần chuyên biệt của lớp con
    );
  }
}
```

*2. Ví dụ cách sinh viên áp dụng (Kế thừa BaseScreen):*
```dart
// Ví dụ: Sinh viên Lụa phát triển SettingsScreen kế thừa BaseScreen
class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  String get title => 'Cài đặt Tài khoản'; // Lụa định nghĩa tiêu đề riêng

  @override
  Widget buildBody(BuildContext context) {
    // Lụa thiết kế giao diện body chuyên biệt
    return Center(
      child: Text('Giao diện cài đặt do Lụa thiết kế'),
    );
  }
}

// Ví dụ: Sinh viên Hoài phát triển DictionaryScreen kế thừa BaseScreen
class DictionaryScreen extends BaseScreen {
  const DictionaryScreen({super.key});

  @override
  String get title => 'Từ điển Ký hiệu'; // Hoài định nghĩa tiêu đề riêng

  @override
  Widget buildBody(BuildContext context) {
    // Hoài thiết kế danh sách từ vựng chuyên biệt
    return ListView(
      children: [
        ListTile(title: Text('Giao diện từ điển do Hoài thiết kế')),
      ],
    );
  }
}
```

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
