import 'package:chefapp/domain/model/category_model.dart';

abstract interface class ICategoriesRepository {
  Future<List<CategoryModel>> fetchCategories();
  Future<CategoryModel> postNewCategory(String categoryName);
  Future<List<String>> fetchCategoriesForDish(int id);
}
