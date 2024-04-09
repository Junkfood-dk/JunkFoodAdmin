import 'package:chefapp/Data/database_provider.dart';
import 'package:chefapp/Data/interface_categories_repository.dart';
import 'package:chefapp/Domain/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'categories_repository.g.dart';

class CategoriesRepository implements ICategoriesRepository {
  SupabaseClient database;

  CategoriesRepository({required this.database});
  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await database.from("Allergens").select();

      final List<CategoryModel> allergens = List<CategoryModel>.from(
          response.map((allergenData) => CategoryModel.fromJson(allergenData)));

      return allergens;
    } catch (error) {
      debugPrint("Error fetching allergens: $error");
      return [];
    }
  }

  @override
  Future<CategoryModel> postNewCategory(String categoryName) async {
    final allergen = CategoryModel(name: categoryName);
    try {
      return await database
          .from("Allergens")
          .insert(allergen.toJson())
          .select()
          .then((rows) => CategoryModel.fromJson(rows[0]));
    } catch (error) {
      debugPrint("Error saving new allergen: $error");
      throw Exception("Failed to save new allergen: $error");
    }
  }
}

@riverpod
ICategoriesRepository categoriesRepository(CategoriesRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return CategoriesRepository(database: database);
}
