import 'package:chefapp/data/allergens_repository.dart';
import 'package:chefapp/data/categories_repository.dart';
import 'package:chefapp/data/database_provider.dart';
import 'package:chefapp/data/interface_allergens_repository.dart';
import 'package:chefapp/data/interface_categories_repository.dart';
import 'package:chefapp/data/interface_dish_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/domain/model/dish_type_model.dart';
import 'package:chefapp/domain/model/save_dish_model.dart';
import 'package:chefapp/extensions/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'dish_repository.g.dart';

class DishRepository implements IDishRepository {
  SupabaseClient database;
  IAllergensRepository allergenRepo;
  ICategoriesRepository categoriesRepo;

  DishRepository({
    required this.database,
    required this.allergenRepo,
    required this.categoriesRepo,
  });

  @override
  Future<List<DishModel>> fetchDishOfTheDay([DateTime? date]) async {
    final dishes = await database
        .from('Dish_Schedule')
        .select(
          'Dishes(id, title, description, calories, Dish_type(id, dish_type), image)',
        )
        .filter(
          'date',
          'eq',
          date?.toIso8601String() ?? DateTime.now().toSupaDate(),
        )
        .then(
          (rows) =>
              rows.map((json) => DishModel.fromJson(json['Dishes'])).toList(),
        )
        .then(
          (list) => list..sort((d1, d2) => d1.dishType.id - d2.dishType.id),
        );

    for (DishModel dish in dishes) {
      var allergens = await allergenRepo.fetchAllergensForDish(dish.id!);
      dish.allergens = allergens;
      var categories = await categoriesRepo.fetchCategoriesForDish(dish.id!);
      dish.categories = categories;
    }

    return dishes;
  }

  @override
  Future<int> postDishOfTheDay(
    String title,
    String description,
    int calories,
    String imageUrl,
    DishTypeModel dishType, [
    DateTime? date,
  ]) async {
    try {
      SaveDishModel newDish = SaveDishModel(
        title: title,
        dishType: dishType,
        description: description,
        calories: calories,
        imageUrl: imageUrl,
      );
      var row = await database.from('Dishes').insert(newDish).select('id');
      var id = row[0]['id'];
      var response = await database.from('Dish_Schedule').insert(
        {'id': id, 'date': (date ?? DateTime.now()).toSupaDate()},
      ).select('id');
      return response[0]['id'];
    } catch (e) {
      debugPrint(e.toString());
    }
    return -1;
  }

  @override
  Future<int> addToTodaysMenu(int id) async {
    var response = await database.from('Dish_Schedule').insert(
      {'id': id, 'date': DateTime.now().toSupaDate()},
    ).select('id');
    return response.first['id'];
  }

  @override
  Future<bool> removeFromMenu(int id, [DateTime? date]) async {
    try {
      await database
          .from('Dish_Schedule')
          .delete()
          .eq('id', id)
          .eq('date', (date ?? DateTime.now()).toSupaDate());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void addAllergeneToDish(AllergenModel allergene, int dishId) async {
    await database
        .from('Allergens_to_Dishes')
        .insert({'allergen_id': allergene.id, 'dish_id': dishId});
  }

  @override
  void addCategoryToDish(int categoryId, int dishId) async {
    await database
        .from('Categories_to_Dishes')
        .insert({'category_id': categoryId, 'dish_id': dishId});
  }
}

@riverpod
IDishRepository dishRepository(DishRepositoryRef ref) {
  return DishRepository(
    database: ref.read(databaseProvider),
    allergenRepo: ref.read(allergensRepositoryProvider),
    categoriesRepo: ref.read(categoriesRepositoryProvider),
  );
}
