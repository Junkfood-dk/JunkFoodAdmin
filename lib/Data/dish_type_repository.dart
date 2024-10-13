import 'package:chefapp/data/database_provider.dart';
import 'package:chefapp/data/interface_dish_type_repository.dart';
import 'package:chefapp/domain/model/dish_type_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dish_type_repository.g.dart';

class DishTypeRepository implements IDishTypeRepository {
  SupabaseClient database;

  DishTypeRepository({required this.database});
  @override
  Future<List<DishTypeModel>> fetchDishTypes() async {
    try {
      final response = await database.from('Dish_type').select();
      return response
          .map((typeData) => DishTypeModel.fromJson(typeData))
          .toList();
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}

@riverpod
IDishTypeRepository dishTypeRepository(DishTypeRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return DishTypeRepository(database: database);
}
