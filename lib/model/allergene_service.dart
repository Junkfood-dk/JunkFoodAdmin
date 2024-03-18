import 'package:chefapp/model/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AllergeneService extends ChangeNotifier {
  final SupabaseClient database;
  final Map<String, bool> _allergenToggles = {
    "Gluten": false,
    "Fish": false,
    "Nuts": false,
    "Lactose": false,
  };
  AllergeneService({required this.database});

  Map<String, bool> get allergenes => _allergenToggles;

  Future<List<AllergenModel>> fetchAllergens() async {
    try {
      final response = await database.from("Allergens").select("allergen_name");

      final List<AllergenModel> allergens = List<AllergenModel>.from(
          response.map((allergenData) => AllergenModel.fromJson(allergenData)));
      
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

  List<String> getSelectedAllergens() {
    return _allergenToggles.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  void toggleAllergen(String allergenName) {
    if (_allergenToggles.containsKey(allergenName)) {
      _allergenToggles[allergenName] = !_allergenToggles[allergenName]!;
      notifyListeners();
    }
  }
}
