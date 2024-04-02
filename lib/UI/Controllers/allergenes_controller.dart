import 'package:chefapp/Domain/Model/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

@riverpod
class AllergenesController extends _$AllergenesControllerProvider {
  final SupabaseClient database;
  final List<AllergenModel> _allergenes = [];
  Future<List<AllergenModel>> build() {}

  List<AllergenModel> get allergenes => _allergenes;

  void postNewAllergen(String allergenName) {}

  Future<void> addAllergeneToDish(AllergenModel allergene, int dishId) async {
    await database
        .from("Allergens_to_Dishes")
        .insert({"allergen_id": allergene.id, "dish_id": dishId});
  }
}
