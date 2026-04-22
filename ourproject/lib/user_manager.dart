// lib/user_manager.dart
import 'user_model.dart';

class UserManager {
  // Biến là danh sách của các User (Câu 4 yêu cầu)
  List<User> listUsers = [];

  // 1. Create (Tạo): Thêm một bản ghi mới
  void create(User user) {
    listUsers.add(user);
    print("✅ Đã thêm người dùng: ${user.displayName}");
  }

  // 2. Read (Đọc): Hiển thị tất cả bản ghi
  void read() {
    print("\n--- 📋 DANH SÁCH NGƯỜI DÙNG SASL ---");
    if (listUsers.isEmpty) {
      print("❌ Danh sách hiện đang trống.");
    } else {
      for (var user in listUsers) {
        user.showDetails(); // Đảm bảo trong user_model.dart đã có hàm này
      }
    }
  }

  // 3. Edit (Sửa): Sửa bản ghi theo id cụ thể
  void edit(int id, {String? newName, String? newLevel, int? newPoints}) {
    try {
      // Tìm user có ID khớp
      var user = listUsers.firstWhere((u) => u.uid == id);
      
      if (newName != null) user.displayName = newName;
      if (newLevel != null) user.level = newLevel;
      if (newPoints != null) user.totalPoints = newPoints;
      
      print("🔄 Đã cập nhật thông tin cho ID: $id");
    } catch (e) {
      print("⚠️ Không tìm thấy người dùng có ID: $id để sửa.");
    }
  }

  // 4. Delete (Xóa): Bổ sung cho đầy đủ CRUD
  void delete(int id) {
    int initialLength = listUsers.length;
    listUsers.removeWhere((u) => u.uid == id);
    
    if (listUsers.length < initialLength) {
      print("🗑️ Đã xóa ID: $id thành công.");
    } else {
      print("⚠️ Không tìm thấy ID: $id để xóa.");
    }
  }
}