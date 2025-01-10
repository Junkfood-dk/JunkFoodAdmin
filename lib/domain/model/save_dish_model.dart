import 'package:chefapp/domain/model/dish_type_model.dart';

class SaveDishModel {
  String title;
  String description;
  int calories;
  DishTypeModel dishType;
  String imageUrl;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'dish_type': dishType.id,
    };
  }

  SaveDishModel({
    required this.title,
    required this.dishType,
    this.description = '',
    this.calories = 0,
    this.imageUrl = '',
  });
}
