class DishTypeModel {
  int id;
  String type;

  DishTypeModel({required this.id, required this.type});

  Map<String, dynamic> toJson() {
    return {'dish_type': type};
  }

  static DishTypeModel fromJson(Map<String, dynamic> input) {
    return DishTypeModel(
        type: input.containsKey("dish_type")
            ? input["dish_type"]
            : throw Exception("Missing type"),
        id: input.containsKey("id")
            ? input["id"]
            : throw Exception("Missing id"));
  }
}
