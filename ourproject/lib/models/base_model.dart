abstract class BaseModel<T> {
  /// ID tổng quát
  final T id;

  /// Tiêu đề/nội dung chính
  final String title;

  /// Mô tả
  final String description;

  /// Ngày tạo
  final DateTime createdAt;

  /// Constructor
  BaseModel({
    required this.id,
    required this.title,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Hiển thị thông tin
  void showInfo() {
    print("ID: $id | "
        "Title: $title | "
        "Description: $description | "
        "Created At: $createdAt");
  }

  @override
  String toString() {
    return "[$id] $title";
  }
}
