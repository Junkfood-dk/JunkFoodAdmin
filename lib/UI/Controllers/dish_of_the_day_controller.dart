import 'package:chefapp/Data/allergenes_repository.dart';
import 'package:chefapp/Data/dish_repository.dart';
import 'package:chefapp/Domain/Model/allergen_model.dart';
import 'package:chefapp/Domain/Model/dish_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dish_of_the_day_controller.g.dart';

@riverpod
class DishOfTheDayController extends _$DishOfTheDayController {
  @override
  // Initial fetch of dishes
  Future<List<DishModel>> build() async {
    var repository = ref.read(dishRepositoryProvider);
    List<DishModel> dishModelList = await repository.fetchDishOfTheDay();
    return dishModelList.isNotEmpty ? dishModelList : [];
  }

  Future<void> updateDishOfTheDay() async {
    var repository = ref.read(dishRepositoryProvider);
    List<DishModel> dishModelList = await repository.fetchDishOfTheDay();
    state = dishModelList.isNotEmpty
        ? AsyncData(dishModelList)
        : const AsyncData([]);
  }

  Future<void> postDishOfTheDay(
      String title, String description, int calories, String imageUrl) async {
    var repository = ref.read(dishRepositoryProvider);
    var newDishId =
        repository.postDishOfTheDay(title, description, calories, imageUrl);
  }

  void _addAllergenToDish(AllergenModel allergen, int id) {
    var repository = ref.read(dishRepositoryProvider);
    repository.addAllergeneToDish(allergen, id);
  }
}
