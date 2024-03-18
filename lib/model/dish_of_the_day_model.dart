import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class DishOfTheDayModel extends ChangeNotifier {
  final SupabaseClient database;
  DishOfTheDayModel({required this.database});
  DishModel? _dishOfTheDay;

  Future<void> fetchDishOfTheDay() async {
    Future.microtask(() async {
      var response = await database
          .from("Dish_Schedule")
          .select()
          .filter("date", "eq", DateTime.now().toIso8601String());
      if (response.isNotEmpty) {
        var dishOfTheDay = await database
            .from("Dishes")
            .select()
            .filter("id", "eq", response[0]["id"]);
        _dishOfTheDay = DishModel.fromJson(dishOfTheDay[0]);
      } else {
        _dishOfTheDay = null;
      }
      notifyListeners();
    });
  }

  DishModel get dishOfTheDay {
    if (_dishOfTheDay != null) {
      return _dishOfTheDay!;
    } else {
      return DishModel(title: "There is no dish of the day");
    }
  }

  Future<bool> get hasDishOfTheDay async {
    await fetchDishOfTheDay();
    return _dishOfTheDay != null;
  }

  Future<int> postDishOfTheDay(
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
    return id;
  }
}
