import 'package:chefapp/Data/dish_repository.dart';
import 'package:chefapp/Domain/model/dish_model.dart';
import 'package:chefapp/Domain/model/dish_type_model.dart';
import 'package:chefapp/UI/Controllers/dish_of_the_day_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dish_of_the_day_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DishRepository>()])
void main() {
  ProviderContainer createContainer({
    ProviderContainer? parent,
    List<Override> overrides = const [],
    List<ProviderObserver>? observers,
  }) {
    // Create a ProviderContainer, and optionally allow specifying parameters.
    final container = ProviderContainer(
      parent: parent,
      overrides: overrides,
      observers: observers,
    );

    // When the test ends, dispose the container.
    addTearDown(container.dispose);

    return container;
  }

  test('DishOfTheDayProvider returns an empty list if there are no dishes',
      () async {
    // Arrange
    final mockDishRepository = MockDishRepository();
    when(mockDishRepository.fetchDishOfTheDay())
        .thenAnswer((realInvocation) => Future.value(<DishModel>[]));
    mockDishRepository.fetchDishOfTheDay();
    final container = createContainer(overrides: [
      dishRepositoryProvider.overrideWithValue(mockDishRepository)
    ]);

    container.read(dishOfTheDayControllerProvider.future);

    completion([]);
  });

  test('DishOfTheDayProvider returns a list with one element', () async {
    // Arrange
    final mockDishRepository = MockDishRepository();
    when(mockDishRepository.fetchDishOfTheDay()).thenAnswer((realInvocation) =>
        Future.value(<DishModel>[DishModel(title: "Test1", dishType: DishTypeModel(id: -1, type: ""))]));
    mockDishRepository.fetchDishOfTheDay();
    final container = createContainer(overrides: [
      dishRepositoryProvider.overrideWithValue(mockDishRepository)
    ]);

    container.read(dishOfTheDayControllerProvider.future);

    completion(hasLength(1));
  });
}
