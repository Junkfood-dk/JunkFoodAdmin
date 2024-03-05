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
}
