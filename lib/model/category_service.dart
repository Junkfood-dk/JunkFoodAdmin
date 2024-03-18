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

  CategoryService({required this.database});

  Map<String, bool> get categories => _categoryToggles;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await database.from("Categories").select("category_name");
      final List<CategoryModel> categories = List<CategoryModel>.from(
        response.map((categoryData) => CategoryModel.fromJson(categoryData))
      );
      return categories;
    } catch (error) {
      debugPrint("Error fetching allergens. $error");
      return [];
    }
  }

  Future <void> saveNewCategory(String categoryName) async {
    final category = CategoryModel(name: categoryName);

    try {
      final reponse = await database.from("Categories").insert(category.toJson());
      if (reponse["error"] != null) {
        debugPrint("Error saving new categories: ${reponse["error"]}");
        throw Exception("Failed to save new categories: ${reponse["error"]}");
      } else {
        debugPrint("New category saved successfully");
        final data = reponse["data"];
        if (data != null && data is List && data.isNotEmpty) {
          
        }
        notifyListeners();
      }
    } catch (error) {
      debugPrint("Error saving new categories: $error");
      throw Exception("Failed to save new category: $error");
    }
  }

  List<String> getSelectedCategories() {
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
  }
}
