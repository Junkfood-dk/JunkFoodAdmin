class DishModel {
  String title;
  String description;
  int calories;
  DishModel({required this.title, this.description = "", this.calories = 0});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
    };
  }
}
