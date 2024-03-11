import 'package:flutter/material.dart';

import '../main.dart';

//list of allergens 
class AllergenModel extends ChangeNotifier {
  AllergenModel? _allAllergens;

  AllergenModel({});

  Future<void> fetchAllergens() async {
    var allAllergens = await supabase.from("Allergens").select();
    _allAllergens = _Allergen.fromJson(allAllergens as Map<String, dynamic>) as AllergenModel?;
    notifyListeners();
  }  
}





class _Allergen {
  int id;
  String name;
  _Allergen({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static _Allergen fromJson(Map<String, dynamic> input) {
    return _Allergen(
        name: input.containsKey("allergen_name") ? input["allergen_name"] : "",
        id: input.containsKey("id") ? input["id"] : "");
  }
}
