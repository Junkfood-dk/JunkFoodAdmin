import 'package:chefapp/Domain/model/allergen_model.dart';
import 'package:chefapp/Domain/model/dish_model.dart';
import 'package:chefapp/Domain/model/dish_type_model.dart';

abstract interface class IDishRepository {
  Future<List<DishModel>> fetchDishOfTheDay();
  Future<int> postDishOfTheDay(String title, String description, int calories,
      String imageUrl, DishTypeModel dishType);
  void addAllergeneToDish(AllergenModel allergene, int dishId);
}
