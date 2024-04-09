
import 'package:chefapp/Data/categories_repository.dart';
import 'package:chefapp/Domain/model/category_model.dart';
import 'package:chefapp/UI/Controllers/selected_categories_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_controller.g.dart';

@riverpod
class CategoriesController extends _$CategoriesController {
  @override
  Future<List<CategoryModel>> build() async {
    var repository = ref.read(categoriesRepositoryProvider);
    return await repository.fetchCategories();
  }

  Map<CategoryModel, bool> _copyWith(Map<CategoryModel, bool> oldMap) {
    Map<CategoryModel, bool> newMap = {};
    newMap.addAll(oldMap);
    return newMap;
  }

  void postNewCategory(String categoryName) async {
    var repository = ref.read(categoriesRepositoryProvider);
    var newCategory = await repository.postNewCategory(categoryName);
    var oldState =
        ref.read(selectedCategoriesControllerProvider.notifier).state.value!;
    oldState[newCategory] = false; //
    ref.read(selectedCategoriesControllerProvider.notifier).state =
        AsyncData(_copyWith(oldState));
  }
}
