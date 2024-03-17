import 'package:chefapp/model/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AllergeneService extends ChangeNotifier {
  final SupabaseClient database;
  final List<AllergenModel> _allergenes = [];
  AllergeneService({required this.database});

  List<AllergenModel> get allergenes => _allergenes;

  Future<List<AllergenModel>> fetchAllergens() async {
    try {
      final response = await database.from("Allergens").select();

      final List<AllergenModel> allergens = List<AllergenModel>.from(
          response.map((allergenData) => AllergenModel.fromJson(allergenData)));

      for (var allergene in allergens) {
        bool exists = false;
        for (var existingAllergene in _allergenes) {
          if (allergene.name == existingAllergene.name) {
            exists = true;
            break;
          }
        }
        if (!exists) {
          _allergenes.add(allergene);
        }
      }
      return allergens;
    } catch (error) {
      debugPrint("Error fetching allergens: $error");
      return [];
    }
  }

  Future<void> saveNewAllergen(String allergenName) async {
    final allergen = AllergenModel(name: allergenName);

    try {
      final response =
          await database.from("Allergens").insert(allergen.toJson());

      if (response['error'] != null) {
        debugPrint("Error saving new allergen: ${response['error']}");
        throw Exception("Failed to save new allergen: ${response['error']}");
      } else {
        debugPrint("New allergen saved successfully");
        final data = response['data'];
        if (data != null && data is List && data.isNotEmpty) {
          //selectedAllergens.add(AllergenModel.fromJson(data[0]));
        }
        notifyListeners();
      }
    } catch (error) {
      debugPrint("Error saving new allergen: $error");
      throw Exception("Failed to save new allergen: $error");
    }
  }

  Future<void> addAllergeneToDish(AllergenModel allergene, int dishId) async {
    await database
        .from("Allergens_to_Dishes")
        .insert({"allergen_id": allergene.id, "dish_id": dishId});
  }
}
