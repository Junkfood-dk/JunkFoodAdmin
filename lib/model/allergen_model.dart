class AllergenModel {
  int id;
  String name;
  AllergenModel({required this.name, this.id = -1});

  Map<String, dynamic> toJson() {
    return {'allergen_name': name};
  }

  static AllergenModel fromJson(Map<String, dynamic> input) {
    return AllergenModel(
        name: input.containsKey("allergen_name")
            ? input["allergen_name"]
            : throw Exception("Missing name"),
        id: input.containsKey("id")
            ? input["id"]
            : throw Exception("Missing id"));
  }
}
