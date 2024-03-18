import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'fakeSupaBase.dart';

void main() {
  test('hasDishOfTheDay returns false if there is no dish of the day',
      () async {
    // Arrange
    SupabaseClient database = FakeSupabase();
    var dishOfTheDayModel = DishOfTheDayModel(database: database);

    //Act
    var response = await dishOfTheDayModel.hasDishOfTheDay;

    //Assert
    expect(response, false);
  });

  test(
      'dishOfTheDay returns a DishModel with title "There is no dish of the day"',
      () async {
    // Arrange
    SupabaseClient database = FakeSupabase();
    var dishOfTheDayModel = DishOfTheDayModel(database: database);

    //Act
    var dishModel = dishOfTheDayModel.dishOfTheDay;

    //Assert
    expect(dishModel.title, "There is no dish of the day");
  });
}
