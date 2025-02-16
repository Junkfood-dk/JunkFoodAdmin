class CategoryModel {
  int id;
  String name;
  CategoryModel({required this.name, this.id = -1});

  Map<String, dynamic> toJson() {
    return {'category_name': name};
  }

  static CategoryModel fromJson(Map<String, dynamic> input) {
    return CategoryModel(
      name: input.containsKey('category_name')
          ? input['category_name']
          : throw Exception('Missing category name'),
      id: input.containsKey('id')
          ? input['id']
          : throw Exception('Missing category id'),
    );
  }
}
