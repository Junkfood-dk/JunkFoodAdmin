import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/domain/model/dish_type_model.dart';

abstract interface class IDishRepository {
  Future<List<DishModel>> fetchDishOfTheDay([DateTime? date]);
  Future<int> postDishOfTheDay(
    String title,
    String description,
    int calories,
    String imageUrl,
    DishTypeModel dishType, [
    DateTime? date,
  ]);
  Future<int> addToTodaysMenu(int id);
  Future<bool> removeFromMenu(int id, [DateTime? date]);
  void addAllergeneToDish(AllergenModel allergene, int dishId);
}
