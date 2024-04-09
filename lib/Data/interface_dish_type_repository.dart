import 'package:chefapp/Domain/model/dish_type_model.dart';

abstract interface class IDishTypeRepository {
  Future<List<DishTypeModel>> fetchDishTypes();
}
