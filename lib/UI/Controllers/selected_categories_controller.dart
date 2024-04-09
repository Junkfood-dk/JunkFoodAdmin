import 'package:chefapp/Data/categories_repository.dart';
import 'package:chefapp/Domain/model/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_categories_controller.g.dart';

@riverpod
class SelectedCategoriesController extends _$SelectedCategoriesController {
  @override
  Future<Map<CategoryModel, bool>> build() async {
    var repository = ref.read(categoriesRepositoryProvider);
    var categories = await repository.fetchCategories();
    return Map.fromIterable(categories,
        value: (_) => false); // maps all categories to a false value
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

  void setSelected(CategoryModel category) {
    state.value![category] = !state.value![category]!;
    state = AsyncData(Map.from(state.value!));
  }
}
