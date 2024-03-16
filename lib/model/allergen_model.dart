import 'package:chefapp/main.dart';
import 'package:flutter/material.dart';

class AllergenModel {
  String name;
  AllergenModel({required this.name});

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  static AllergenModel fromJson(Map<String, dynamic> input) {
    return AllergenModel(name: input.containsKey("allergen_name") as String);
    // id: input.containsKey("id") as int);
  }

  Future<void> saveNewAllergen(
      String name) async {
    AllergenModel newAllergen = AllergenModel(
        name: name);
    var row = await supabase.from("Allergens").insert(newAllergen).select("id");
    //var id = row[0]['id'];
    //await supabase.from("Dish_Schedule").insert(
        //{'id': id, 'date': DateTime.now().toIso8601String()}).select("id");
  }


}
