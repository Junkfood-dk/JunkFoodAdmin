import 'package:chefapp/Domain/model/dish_type_model.dart';
import 'package:flutter/material.dart';

class DishModel {
  String title;
  String description;
  int calories;
  DishTypeModel dishType;
  String imageUrl;

  DishModel(
      {required this.title,
      required this.dishType,
      this.description = "",
      this.calories = 0,
      this.imageUrl = ""});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'dish_type': dishType.id,
    };
  }

  static DishModel fromJson(Map<String, dynamic> input) {
    return DishModel(
        title: input.containsKey("title")
            ? input["title"]
            : throw Exception("No title provided"),
        description:
            input.containsKey("description") ? input["description"] : "",
        calories: input.containsKey("calories") ? input["calories"] : 0,
        imageUrl: input.containsKey("image") ? input["image"] : "",
        dishType: input.containsKey("Dish_type")
            ? DishTypeModel.fromJson(input["Dish_type"])
            : throw Exception("No dish type"));
  }
}
