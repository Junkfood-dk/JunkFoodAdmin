import 'package:chefapp/Domain/model/dish_type_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_dish_type_controller.g.dart';

@riverpod
class SelectedDishTypeController extends _$SelectedDishTypeController {
  @override
  DishTypeModel? build() {
    return null;
  }

  void selectDishType(DishTypeModel dishType) {
    state = dishType;
  }
}
