class UserModel {
  int id;
  String name;
  DateTime createdAt; // Ngày tạo tài khoản
  String? email; // Email (có thể có hoặc không)
  bool isActive; // Trạng thái hoạt động

  // Hàm khởi tạo (Constructor)
  UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.email,
    this.isActive = true,
  });

  // --- CÁC PHƯƠNG THỨC (METHODS) ---

  // 1. Phương thức lấy thời gian tham gia (tính theo số ngày)
  int getJoiningDays() {
    return DateTime.now().difference(createdAt).inDays;
  }

  // 2. Phương thức cập nhật thông tin người dùng
  void updateName(String newName) {
    if (newName.isNotEmpty) {
      this.name = newName;
      print("Đã cập nhật tên thành: $newName");
    }
  }

  // 3. Phương thức chuyển đổi trạng thái hoạt động
  void toggleStatus() {
    isActive = !isActive;
  }

  // 4. Phương thức hiển thị profile tóm tắt
  void displayProfile() {
    print("User: $name | Email: ${email ?? 'N/A'} | Active: $isActive");
  }
}

//  void main() {
//   // 1. Khởi tạo một đối tượng User cụ thể
//   UserModel user1 = UserModel(
//     name: "Nguyễn Văn A",
//     createdAt:
//         DateTime.now().subtract(Duration(days: 10)), // Tạo từ 10 ngày trước
//   );

//   // 2. Chạy thử các phương thức đã viết
//   print("--- Kiểm tra thông tin ---");
//   user1.displayProfile();

//   print("--- Kiểm tra số ngày tham gia ---");
//   print("Đã tham gia: ${user1.getJoiningDays()} ngày");

//   print("--- Thử cập nhật tên ---");
//   user1.updateName("Nguyễn Văn B");
//   user1.displayProfile();
// }
