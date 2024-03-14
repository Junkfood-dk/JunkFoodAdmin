import 'package:flutter/material.dart';

class AllergenModel extends ChangeNotifier {
  int id;
  String name;
  AllergenModel({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static AllergenModel fromJson(Map<String, dynamic> input) {
    return AllergenModel(
        name: input.containsKey("allergen_name") as String,
        id: input.containsKey("id") as int);
  }
}
