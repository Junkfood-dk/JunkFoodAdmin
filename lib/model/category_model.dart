class CategoryModel {
  String name;
  CategoryModel({required this.name});

  Map<String, dynamic> toJson() {
    return {'category_name': name};
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["category_name"] as String,
    );
  }
}