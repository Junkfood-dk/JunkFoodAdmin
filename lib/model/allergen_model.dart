import 'package:chefapp/main.dart';
import 'package:flutter/material.dart';

class AllergenModel {
  String name;
  AllergenModel({required this.name});

  Map<String, dynamic> toJson() {
    return {'allergen_name': name};
  }

  static AllergenModel fromJson(Map<String, dynamic> input) {
    return AllergenModel(name: input.containsKey("allergen_name") as String);
    // id: input.containsKey("id") as int);
  }
}
