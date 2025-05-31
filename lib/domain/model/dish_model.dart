import 'package:chefapp/domain/model/dish_type_model.dart';

class DishModel {
  int? id;
  String title;
  String description;
  int calories;
  DishTypeModel dishType;
  String imageUrl;
  List<String> allergens;
  List<String> categories;

  DishModel({
    this.id,
    required this.title,
    required this.dishType,
    this.description = '',
    this.calories = 0,
    this.imageUrl = '',
    this.allergens = const [],
    this.categories = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'calories': calories,
      'image': imageUrl,
      'dish_type': dishType.id,
      'allergens': allergens,
      'categories': categories,
    };
  }

  static DishModel fromJson(Map<String, dynamic> input) {
    return DishModel(
      id: input.containsKey('id')
          ? input['id']
          : throw Exception('No id provided'),
      title: input.containsKey('title')
          ? input['title']
          : throw Exception('No title provided'),
      description: input.containsKey('description') ? input['description'] : '',
      calories: input.containsKey('calories') ? input['calories'] : 0,
      imageUrl: input.containsKey('image') ? input['image'] : '',
      dishType: input.containsKey('Dish_type') && input['Dish_type'] != null
          ? DishTypeModel.fromJson(input['Dish_type'])
          : DishTypeModel(id: -1, type: 'No dish type'),
      allergens: input.containsKey('allergens') ? input['allergens'] : [],
      categories: input.containsKey('categories') ? input['categories'] : [],
    );
  }
}
