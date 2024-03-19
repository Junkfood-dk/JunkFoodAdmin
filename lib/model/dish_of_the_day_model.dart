import 'package:chefapp/model/dish_model.dart';
import 'package:chefapp/model/dish_type_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class DishOfTheDayModel extends ChangeNotifier {
  final SupabaseClient database;
  DishOfTheDayModel({required this.database});
  List<DishModel> _dishesOfTheDay = [];

  Future<void> fetchDishOfTheDay() async {
    Future.microtask(() async {
      var response = await database
          .from("Dish_Schedule")
          .select()
          .filter("date", "eq", DateTime.now().toIso8601String());
      if (response.isNotEmpty) {
        var dishesOfTheDay = await database
            .from("Dishes")
            .select()
            .filter("id", "eq", response[0]["id"]);
        var fetchedDishes = List<DishModel>.from(
            dishesOfTheDay.map((dish) => DishModel.fromJson(dish))).toList();
        for (var fetchedDish in fetchedDishes) {
          bool exists = false;
          for (var existingDish in _dishesOfTheDay) {
            if (fetchedDish.id == existingDish.id) {
              exists = true;
              break;
            }
          }
          if (!exists) {
            debugPrint("Adding dish ${fetchedDish.id}");
            _dishesOfTheDay.add(fetchedDish);
          }
        }
      } else {
        _dishesOfTheDay = [];
      }
      notifyListeners();
    });
  }

  List<DishModel> get dishesOfTheDay {
    return _dishesOfTheDay;
  }

  Future<bool> get hasDishesOfTheDay async {
    await fetchDishOfTheDay();
    return _dishesOfTheDay.isNotEmpty;
  }

  Future<int> postDishOfTheDay(String title, String description, int calories,
      String imageUrl, DishTypeModel dishType) async {
    DishModel newDish = DishModel(
        title: title,
        description: description,
        calories: calories,
        imageUrl: imageUrl,
        dishType: dishType.id);
    var row = await database.from("Dishes").insert(newDish).select("id");
    var id = row[0]['id'];
    await database.from("Dish_Schedule").insert(
        {'id': id, 'date': DateTime.now().toIso8601String()}).select("id");
    return id;
  }
}
