import 'package:chefapp/Data/interface_dish_repository.dart';
import 'package:chefapp/Domain/Model/allergen_model.dart';
import 'package:chefapp/Domain/Model/dish_model.dart';

class FakeDishRepository implements IDishRepository{
  @override
  void addAllergeneToDish(AllergenModel allergene, int dishId) {
    // TODO: implement addAllergeneToDish
  }

  @override
  Future<List<DishModel>> fetchDishOfTheDay() {
    // TODO: implement fetchDishOfTheDay
    return Future(() => []);
  }

  @override
  Future<int> postDishOfTheDay(String title, String description, int calories, String imageUrl) {
    // TODO: implement postDishOfTheDay
    throw UnimplementedError();
  }
  
}