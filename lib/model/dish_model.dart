class DishModel {
  String title;
  String description;
  int calories;
  String imageUrl;
  DishModel(
      {required this.title,
      this.description = "",
      this.calories = 0,
      this.imageUrl = ""});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl
    };
  }

  static DishModel fromJson(Map<String, dynamic> input) {
    return DishModel(
        title: input.containsKey("title")
            ? input["title"]
            : throw Exception("No title provided"),
        description:
            input.containsKey("description") ? input["descirption"] : null,
        calories: input.containsKey("calories") ? input["calories"] : null,
        imageUrl: input.containsKey("image") ? input["image"] : null);
  }
}
