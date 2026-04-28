import 'user_model.dart';

class UserList {
  List<UserModel> listUsers = [];

  // 1. CREATE: Tạo mới và lưu vào danh sách
  void create(UserModel newUser) {
    listUsers.add(newUser);
    print("Đã thêm người dùng: ${newUser.name}");
  }

  // 2. READ: Đọc tất cả các bản ghi
  void readAll() {
    print("--- DANH SÁCH NGƯỜI DÙNG ---");
    if (listUsers.isEmpty) {
      print("Danh sách đang trống!");
    } else {
      for (var user in listUsers) {
        print(
            "ID: ${user.id} | Tên: ${user.name} | Ngày tạo: ${user.createdAt}");
      }
    }
  }

  // 3. EDIT: Sửa bản ghi có ID cụ thể
  void edit(int targetId, String newName) {
    try {
      // Tìm người dùng có ID khớp với targetId
      var user = listUsers.firstWhere((u) => u.id == targetId);
      user.name = newName;
      print("Đã cập nhật ID $targetId thành tên mới: $newName");
    } catch (e) {
      print("Không tìm thấy người dùng có ID: $targetId");
    }
  }
}

void main() {
  UserList manager = UserList();

  // THỰC HIỆN CREATE
  manager.create(UserModel(id: 1, name: "Hoài", createdAt: DateTime.now()));
  manager.create(UserModel(id: 2, name: "Lụa", createdAt: DateTime.now()));

  // THỰC HIỆN READ (Trước khi sửa)
  manager.readAll();

  // THỰC HIỆN EDIT (Sửa người có ID = 1)
  manager.edit(1, "Hoài (Đã sửa tên)");

  // THỰC HIỆN READ (Sau khi sửa)
  manager.readAll();
}
