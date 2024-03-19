import 'package:chefapp/model/dish_type_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class DishTypeService extends ChangeNotifier {
  final SupabaseClient database;
  final List<DishTypeModel> _types = [];
  DishTypeService({required this.database});

  List<DishTypeModel> get types => _types;

  Future<List<DishTypeModel>> fetchDishTypes() async {
    try {
      _types.clear();
      final response = await database.from('Dish_type').select();

      _types.addAll(List<DishTypeModel>.from(
          response.map((typeData) => DishTypeModel.fromJson(typeData))));
      debugPrint(response.length.toString());
      debugPrint(_types.length.toString());
      return _types;
    } catch (error) {
      debugPrint("Error fetching dishtype: $error");
      return [];
    }
  }
}
