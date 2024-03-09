import 'package:chefapp/main.dart';
import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';

class DishOfTheDayModel extends ChangeNotifier {
  DishModel? _dishOfTheDay;

  Future<void> getDishOfTheDay() async {
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
    }
    notifyListeners();
  }

  Future<bool> get hasDishOfTheDay async {
    if (_dishOfTheDay != null) {
      return true;
    }
    getDishOfTheDay();
    return false;
  }
}
