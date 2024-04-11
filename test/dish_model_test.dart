import 'package:chefapp/Domain/model/dish_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'DishModel.toJson() returns a Map<String, dynamic>> of the expected length',
      () {
    // Arrange
    var testDish = DishModel(
        title: "Test", description: "Test", calories: 0, imageUrl: "Test");
    var json = testDish.toJson();

    // Act
    var length = json.length;

    // Assert
    expect(length, 4);
  });

  test(
      'DishModel.fromJson(Map<String, dynamic>>) returns a DishModel with the expected values',
      () {
    // Arrange
    Map<String, dynamic> json = {
      'title': 'Test',
      'description': 'Test',
      'calories': 0,
      'image': 'Test'
    };

    // Act
    DishModel dish = DishModel.fromJson(json);

    // Assert
    expect(dish.title, 'Test');
    expect(dish.description, 'Test');
    expect(dish.calories, 0);
    expect(dish.imageUrl, 'Test');
  });

  test(
      'DishModel.fromJson(Map<String, dynamic>>) throws an Exception when there is no title',
      () {
    // Arrange
    Map<String, dynamic> json = {
      'description': 'Test',
      'calories': 0,
      'image': 'Test'
    };

    // Assert
    expect(() => DishModel.fromJson(json), throwsA(isA<Exception>()));
  });

  test(
      'DishModel.fromJson(Map<String, dynamic>>) defaults description to empty string',
      () {
    // Arrange
    Map<String, dynamic> json = {
      'title': 'Test',
      'calories': 0,
      'image': 'Test'
    };

    // Act
    DishModel dish = DishModel.fromJson(json);

    // Assert
    expect(dish.title, 'Test');
    expect(dish.description, '');
    expect(dish.calories, 0);
    expect(dish.imageUrl, 'Test');
  });

  test('DishModel.fromJson(Map<String, dynamic>>) defaults calories to 0', () {
    // Arrange
    Map<String, dynamic> json = {
      'title': 'Test',
      'description': 'Test',
      'image': 'Test'
    };

    // Act
    DishModel dish = DishModel.fromJson(json);

    // Assert
    expect(dish.title, 'Test');
    expect(dish.description, 'Test');
    expect(dish.calories, 0);
    expect(dish.imageUrl, 'Test');
  });

  test(
      'DishModel.fromJson(Map<String, dynamic>>) defaults image to empty string',
      () {
    // Arrange
    Map<String, dynamic> json = {
      'title': 'Test',
      'description': 'Test',
      'calories': 0,
    };

    // Act
    DishModel dish = DishModel.fromJson(json);

    // Assert
    expect(dish.title, 'Test');
    expect(dish.description, 'Test');
    expect(dish.calories, 0);
    expect(dish.imageUrl, '');
  });
}