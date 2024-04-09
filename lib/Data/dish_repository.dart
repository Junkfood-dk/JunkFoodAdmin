import 'package:chefapp/Data/database_provider.dart';
import 'package:chefapp/Data/interface_dish_repository.dart';
import 'package:chefapp/Domain/model/allergen_model.dart';
import 'package:chefapp/Domain/model/dish_model.dart';
import 'package:chefapp/Domain/model/dish_type_model.dart';
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
            "Dishes(id, title, description, calories, Dish_type(id, dish_type), image)")
        .filter("date", "eq", DateTime.now().toIso8601String())
        .then((rows) =>
            rows.map((json) => DishModel.fromJson(json["Dishes"])).toList());
  }

  @override
  Future<int> postDishOfTheDay(String title, String description, int calories,
      String imageUrl, DishTypeModel dishType) async {
    DishModel newDish = DishModel(
        title: title,
        dishType: dishType,
        description: description,
        calories: calories,
        imageUrl: imageUrl);
    var row = await database.from("Dishes").insert(newDish).select("id");
    var id = row[0]['id'];
    var response = await database.from("Dish_Schedule").insert(
        {'id': id, 'date': DateTime.now().toIso8601String()}).select("id");
    return response[0]['id'];
  }

  @override
  void addAllergeneToDish(AllergenModel allergene, int dishId) async {
    await database
        .from("Allergens_to_Dishes")
        .insert({"allergen_id": allergene.id, "dish_id": dishId});
  }
}

@riverpod
IDishRepository dishRepository(DishRepositoryRef ref) {
  var database = ref.read(databaseProvider);
  return DishRepository(database: database);
}
