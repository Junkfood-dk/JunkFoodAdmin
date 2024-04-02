import 'package:chefapp/Data/database_provider.dart';
import 'package:chefapp/Data/interface_dish_repository.dart';
import 'package:chefapp/Domain/Model/dish_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

part 'dish_repository.g.dart';

class DishRepository implements IDishRepository {
  SupabaseClient database;
  DishRepository({required this.database});
  @override
  Future<List<DishModel>> fetchDishOfTheDay() async {
    return await database
        .from("Dish_Schedule")
        .select(
            "Dish(id, title, description, calories, Dish_type(dish_type), image)")
        .filter("date", "eq", DateTime.now().toIso8601String())
        .then((rows) => rows.map((json) => DishModel.fromJson(json)).toList());
  }

  @override
  void postDishOfTheDay(
      String title, String description, int calories, String imageUrl) async {
    DishModel newDish = DishModel(
        title: title,
        description: description,
        calories: calories,
        imageUrl: imageUrl);
    var row = await database.from("Dishes").insert(newDish).select("id");
    var id = row[0]['id'];
    await database.from("Dish_Schedule").insert(
        {'id': id, 'date': DateTime.now().toIso8601String()}).select("id");
  }
}

@riverpod
IDishRepository dishRepository(DishRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return DishRepository(database: database);
}
