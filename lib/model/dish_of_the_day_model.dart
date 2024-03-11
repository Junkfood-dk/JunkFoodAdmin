import 'package:chefapp/main.dart';
import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';

class DishOfTheDayModel extends ChangeNotifier {
  DishModel? _dishOfTheDay;

  Future<void> fetchDishOfTheDay() async {
    var response = await supabase
        .from("Dish_Schedule")
        .select()
        .filter("date", "eq", DateTime.now().toIso8601String());
    if (response.isNotEmpty) {
      var dishOfTheDay = await supabase
          .from("Dishes")
          .select()
          .filter("id", "eq", response[0]["id"]);
      _dishOfTheDay = DishModel.fromJson(dishOfTheDay[0]);
    } else {
      _dishOfTheDay = null;
    }
    notifyListeners();
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

  Future<void> postDishOfTheDay(
      String title, String description, int calories, String imageUrl) async {
    DishModel newDish = DishModel(
        title: title,
        description: description,
        calories: calories,
        imageUrl: imageUrl);
    var row = await supabase.from("Dishes").insert(newDish).select("id");
    var id = row[0]['id'];
    await supabase.from("Dish_Schedule").insert(
        {'id': id, 'date': DateTime.now().toIso8601String()}).select("id");
  }
}
