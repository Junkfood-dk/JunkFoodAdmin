import 'package:chefapp/data/image_repository.dart';
import 'package:chefapp/data/dish_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/controllers/selected_allergens_controller.dart';
import 'package:chefapp/ui/controllers/selected_categories_controller.dart';
import 'package:chefapp/ui/controllers/selected_dish_type_controller.dart';
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
    final repository = ref.read(dishRepositoryProvider);
    final date = ref.read(Providers.appDate);
    List<DishModel> dishModelList = await repository.fetchDishOfTheDay(date);
    state = dishModelList.isNotEmpty
        ? AsyncData(dishModelList)
        : const AsyncData([]);
    ref.notifyListeners();
  }

  Future<void> postDishOfTheDay(
    String title,
    String description,
    int calories,
    String imageUrl, [
    DateTime? date,
  ]) async {
    var repository = ref.read(dishRepositoryProvider);
    var selectedDishType = ref.read(selectedDishTypeControllerProvider);
    var dbImageUrl =
        await ref.read(imageRepositoryProvider).uploadImageUrl(imageUrl);
    var newDishId = await repository.postDishOfTheDay(
      title,
      description,
      calories,
      dbImageUrl!,
      selectedDishType!,
      date,
    );
    var selectedAllergens = ref
        .read(selectedAllergensControllerProvider.notifier)
        .getAllSelectedAllergens();
    for (var allergen in selectedAllergens) {
      _addAllergenToDish(allergen, newDishId);
    }
    var selectedCategories = ref
        .read(selectedCategoriesControllerProvider.notifier)
        .getAllSelectedCategories()
        .map((cat) => cat.id)
        .toList();
    for (var categoryId in selectedCategories) {
      _addCategoryToDish(categoryId, newDishId);
    }
  }

  void _addAllergenToDish(AllergenModel allergen, int id) {
    var repository = ref.read(dishRepositoryProvider);
    repository.addAllergeneToDish(allergen, id);
  }

  void _addCategoryToDish(int categoryId, int id) {
    var repository = ref.read(dishRepositoryProvider);
    repository.addCategoryToDish(categoryId, id);
  }

  Future<int> addToTodaysMenu(int id) {
    final repository = ref.read(dishRepositoryProvider);
    return repository.addToTodaysMenu(id);
  }

  Future<bool> removeFromMenu(int id, [DateTime? date]) {
    final repository = ref.read(dishRepositoryProvider);
    return repository.removeFromMenu(id, date);
  }
}
