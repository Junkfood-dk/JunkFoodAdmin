import 'package:chefapp/domain/model/dish_type_model.dart';
import 'package:chefapp/ui/controllers/dish_types_controller.dart';
import 'package:chefapp/ui/controllers/selected_dish_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DishTypeDropdownWidget extends ConsumerWidget {
  const DishTypeDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dishTypes = ref.watch(dishTypeControllerProvider);
    var selectedDishTypeController =
        ref.read(selectedDishTypeControllerProvider.notifier);
    switch (dishTypes) {
      case (AsyncData(:final value)):
        return DropdownButtonFormField<DishTypeModel>(
          hint: const Text('Select course type...'),
          items: value
              .map(
                (dishType) => DropdownMenuItem<DishTypeModel>(
                  value: dishType,
                  child: Text(dishType.type),
                ),
              )
              .toList(),
          onChanged: (dishType) =>
              selectedDishTypeController.selectDishType(dishType!),
          value: ref.watch(selectedDishTypeControllerProvider),
          validator: (value) => value == null ? 'Need type' : null,
        );
      case (_):
        return const CircularProgressIndicator();
    }
  }
}
