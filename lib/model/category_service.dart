import 'package:chefapp/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryService extends ChangeNotifier {
  final SupabaseClient database;
  final Map<String, bool> _categoryToggles = {
    "Vegan": false,
    "Fish": false,
    "Pork": false,
    "Beef": false,
  };
  final List<CategoryModel> _categories = [];

  CategoryService({required this.database});

  List<CategoryModel> get categories => _categories;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await database.from("Categories").select();

      final List<CategoryModel> categories= List<CategoryModel>.from(
          response.map((categoryData) => CategoryModel.fromJson(categoryData)));


      for (var category in categories) {
        bool exists = false;
        for (var existingCategory in _categories) {
          if (category.name == existingCategory.name) {
            exists = true;
            break;
          }
        }
        if (!exists) {
          _categories.add(category);
        }
      }
      return categories;
    } catch (error) {
      debugPrint("Error fetching categories. $error");
      return [];
    }
  }

  Future <CategoryModel> saveNewCategory(String categoryName) async {
    final category = CategoryModel(name: categoryName);

    try {
      final reponse = await database.from("Categories").insert(category.toJson()).select();
      notifyListeners();
      return CategoryModel.fromJson(reponse[0]);
    } catch (error) {
      debugPrint("Error saving new categories: $error");
      throw Exception("Failed to save new category: $error");
    }
  }

  Future<void> addCategoryToDish(CategoryModel category, int dishId) async {
    await database 
      .from("Categories_to_Dishes")
      .insert({"category_id" : category.id, "dish_id": dishId});
  }

  /*List<String> getSelectedCategories() {
    return _categoryToggles.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();
  }

  void toggleCategory(String categoryName) {
    if (_categoryToggles.containsKey(categoryName)) {
      _categoryToggles[categoryName] = !_categoryToggles[categoryName]!;
      notifyListeners();
    }
  }*/
}
