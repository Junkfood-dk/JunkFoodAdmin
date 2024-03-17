class CategoryModel {
  String name;
  int? id;
  CategoryModel({required this.name, this.id});

  Map<String, dynamic> toJson() {
    return {'category_name': name};
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["category_name"] as String,
    );
  }
}