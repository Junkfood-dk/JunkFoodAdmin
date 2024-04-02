import 'package:chefapp/Domain/Model/dish_model.dart';

abstract interface class IDishRepository {
  Future<List<DishModel>> fetchDishOfTheDay();
  void postDishOfTheDay(String title, String description, int calories, String imageUrl);
  
}
