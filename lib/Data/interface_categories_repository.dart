import 'package:chefapp/Domain/model/category_model.dart';

abstract interface class ICategoriesRepository {
  Future<List<CategoryModel>> fetchCategories();
  Future<CategoryModel> postNewCategory(String categoryName);
}
