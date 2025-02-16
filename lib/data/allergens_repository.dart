import 'package:chefapp/data/database_provider.dart';
import 'package:chefapp/data/interface_allergens_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'allergens_repository.g.dart';

class AllergensRepository implements IAllergensRepository {
  SupabaseClient database;

  AllergensRepository({required this.database});
  @override
  Future<List<AllergenModel>> fetchAllergens() async {
    try {
      final response = await database.from('Allergens').select();

      final List<AllergenModel> allergens = List<AllergenModel>.from(
        response.map((allergenData) => AllergenModel.fromJson(allergenData)),
      );

      return allergens;
    } catch (error) {
      debugPrint('Error fetching allergens: $error');
      return [];
    }
  }

  @override
  Future<AllergenModel> postNewAllergen(String allergenName) async {
    final allergen = AllergenModel(name: allergenName);
    try {
      return await database
          .from('Allergens')
          .insert(allergen.toJson())
          .select()
          .then((rows) => AllergenModel.fromJson(rows[0]));
    } catch (error) {
      debugPrint('Error saving new allergen: $error');
      throw Exception('Failed to save new allergen: $error');
    }
  }

  @override
  Future<List<String>> fetchAllergensForDish(int id) async {
    return await database
        .from('Allergens_to_Dishes')
        .select('Allergens(allergen_name)')
        .filter('dish_id', 'eq', id)
        .then(
          (rows) => rows
              .map((json) => json['Allergens']['allergen_name'].toString())
              .toList(),
        );
  }
}

@riverpod
IAllergensRepository allergensRepository(AllergensRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return AllergensRepository(database: database);
}
