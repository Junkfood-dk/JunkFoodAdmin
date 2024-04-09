import 'package:chefapp/Data/database_provider.dart';
import 'package:chefapp/Data/interface_allergenes_repository.dart';
import 'package:chefapp/Domain/model/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'allergenes_repository.g.dart';

class AllergenesRepository implements IAllergenesRepository {
  SupabaseClient database;

  AllergenesRepository({required this.database});
  @override
  Future<List<AllergenModel>> fetchAllergenes() async {
    try {
      final response = await database.from("Allergens").select();

      final List<AllergenModel> allergens = List<AllergenModel>.from(
          response.map((allergenData) => AllergenModel.fromJson(allergenData)));

      return allergens;
    } catch (error) {
      debugPrint("Error fetching allergens: $error");
      return [];
    }
  }

  @override
  Future<AllergenModel> postNewAllergen(String allergenName) async {
    final allergen = AllergenModel(name: allergenName);
    try {
      return await database
          .from("Allergens")
          .insert(allergen.toJson())
          .select()
          .then((rows) => AllergenModel.fromJson(rows[0]));
    } catch (error) {
      debugPrint("Error saving new allergen: $error");
      throw Exception("Failed to save new allergen: $error");
    }
  }
}

@riverpod
IAllergenesRepository allergenesRepository(AllergenesRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return AllergenesRepository(database: database);
}
