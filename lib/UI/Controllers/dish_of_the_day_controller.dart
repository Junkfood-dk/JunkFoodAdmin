import 'package:camera/camera.dart';
import 'package:chefapp/data/image_repository.dart';
import 'package:chefapp/data/dish_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/ui/Controllers/selected_allergenes_controller.dart';
import 'package:chefapp/ui/Controllers/selected_dish_type_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    ref.notifyListeners();
  }

  Future<void> postDishOfTheDay(
      String title, String description, int calories, String imageUrl) async {
    var repository = ref.read(dishRepositoryProvider);
    var selectedDishType = ref.read(selectedDishTypeControllerProvider);
    var dbImageUrl =
        await ref.read(imageRepositoryProvider).uploadImage(XFile(imageUrl));
    var newDishId = await repository.postDishOfTheDay(
        title, description, calories, dbImageUrl!, selectedDishType!);
    var selectedAllergens = ref
        .read(selectedAllergenesControllerProvider.notifier)
        .getAllSelectedAllergenes();
    for (var allergen in selectedAllergens) {
      _addAllergenToDish(allergen, newDishId);
    }
  }

  void _addAllergenToDish(AllergenModel allergen, int id) {
    var repository = ref.read(dishRepositoryProvider);
    repository.addAllergeneToDish(allergen, id);
  }
}
