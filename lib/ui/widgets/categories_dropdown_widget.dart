import 'package:chefapp/domain/model/category_model.dart';
import 'package:chefapp/ui/controllers/selected_categories_controller.dart';
import 'package:chefapp/ui/widgets/multiple_select_dropdown.dart'; // Added import
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesDropdownWidget extends ConsumerWidget {
  const CategoriesDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedCategories = ref.watch(selectedCategoriesControllerProvider);

    return selectedCategories.when(
      data: (data) {
        return MultiSelectDropdown<CategoryModel>(
          hint: 'Select categories',
          displayStringForOption: (categorry) => categorry.name,
          items: data.entries.map((a) => a.key).toList(),
          onSelectionChanged: (list) {
            ref
                .read(
                  selectedCategoriesControllerProvider.notifier,
                )
                .setSelected(list);
          },
        );
      },
      error: (o, s) {
        return const Text('Categories not available...');
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
