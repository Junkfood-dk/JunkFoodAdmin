class CategoryModel {
  String name;
  int? id;
  CategoryModel({required this.name, this.id});

  Map<String, dynamic> toJson() {
    return {'category_name': name};
  }

  static CategoryModel fromJson(Map<String, dynamic> input) {
    return CategoryModel(
      //name: json["category_name"] as String,
      name: input.containsKey("category_name")
      ? input["category_name"]
      : throw Exception("Missing name")
    );
  }
}