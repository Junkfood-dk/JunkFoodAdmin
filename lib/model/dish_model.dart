import 'package:flutter/material.dart';

class DishModel {
  String title;
  String description;
  int calories;
  String imageUrl;
  Image? cameraImage;

  DishModel({
    required this.title,
    this.description = "",
    this.calories = 0,
    this.imageUrl = "",
    this.cameraImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'cameraImage':
          cameraImage != null ? 'some_placeholder_for_camera_image' : null
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
        cameraImage: input.containsKey("cameraImage")
            ? Image.network(input[
                "cameraImage"]) // Example: Assuming cameraImage is a network image
            : null);
  }
}
