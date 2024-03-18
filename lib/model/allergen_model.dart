class AllergenModel {
  String name;
  AllergenModel({required this.name});

  Map<String, dynamic> toJson() {
    return {'allergen_name': name};
  }

  static AllergenModel fromJson(Map<String, dynamic> input) {
    return AllergenModel(
        name: input.containsKey("allergen_name")
            ? input["allergen_name"]
            : throw Exception("Missing name"));
    // id: input.containsKey("id") as int);
  }
}
