// lib/user_model.dart

class User {
  int uid;
  String displayName;
  String level;
  int totalPoints;

  // Constructor: Hàm khởi tạo đối tượng
  User({
    required this.uid,
    required this.displayName,
    required this.level,
    required this.totalPoints,
  });

  // Phương thức hiển thị thông tin cụ thể (Theo yêu cầu Câu 3)
  void showDetails() {
    print("User ID: $uid | Tên: $displayName | Cấp độ: $level | Điểm: $totalPoints");
  }

  // Ghi đè toString để in nhanh dữ liệu
  @override
  String toString() => "[$uid] $displayName - $level ($totalPoints pts)";
}