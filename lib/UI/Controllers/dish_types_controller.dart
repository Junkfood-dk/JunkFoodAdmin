import 'package:chefapp/data/dish_type_repository.dart';
import 'package:chefapp/Domain/model/dish_type_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dish_types_controller.g.dart';

@riverpod
class DishTypeController extends _$DishTypeController {
  @override
  Future<List<DishTypeModel>> build() async {
    var repository = ref.read(dishTypeRepositoryProvider);
    return await repository.fetchDishTypes();
  }
}
