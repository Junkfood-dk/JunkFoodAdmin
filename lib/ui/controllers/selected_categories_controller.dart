import 'package:chefapp/data/categories_repository.dart';
import 'package:chefapp/domain/model/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_categories_controller.g.dart';

@riverpod
class SelectedCategoriesController extends _$SelectedCategoriesController {
  @override
  Future<Map<CategoryModel, bool>> build() async {
    var repository = ref.read(categoriesRepositoryProvider);
    var categories = await repository.fetchCategories();
    final map = Map<CategoryModel, bool>.fromIterable(
      categories,
      value: (_) => false,
    );
    return map;
  }

  List<CategoryModel> getAllSelectedCategories() {
    List<CategoryModel> selectedCategories = [];
    state.value!.forEach((category, selected) {
      if (selected) {
        selectedCategories.add(category);
      }
    });
    return selectedCategories;
  }

  void setSelected(List<CategoryModel> selectedCategories) {
    Map<CategoryModel, bool> categories = {};
    final ids = selectedCategories.map((category) => category.id).toList();
    state.value!.forEach((category, selected) {
      if (ids.contains(category.id)) {
        categories.putIfAbsent(category, () => true);
      } else {
        categories.putIfAbsent(category, () => false);
      }
    });
    state = AsyncData(categories);
  }
}
