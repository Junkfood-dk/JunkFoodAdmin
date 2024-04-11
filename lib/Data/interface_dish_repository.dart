import 'package:chefapp/Domain/model/allergen_model.dart';
import 'package:chefapp/Domain/model/dish_model.dart';

abstract interface class IDishRepository {
  Future<List<DishModel>> fetchDishOfTheDay();
  Future<int> postDishOfTheDay(
      String title, String description, int calories, String imageUrl);
  void addAllergeneToDish(AllergenModel allergene, int dishId);
}
