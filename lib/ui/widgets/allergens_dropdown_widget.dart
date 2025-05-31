import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/ui/controllers/selected_allergens_controller.dart';
import 'package:chefapp/ui/widgets/multiple_select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';

class AllergensDropdownWidget extends ConsumerWidget {
  const AllergensDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allergensAsyncValue = ref.watch(selectedAllergensControllerProvider);

    return allergensAsyncValue.when(
      data: (allergens) {
        return MultiSelectDropdown<AllergenModel>(
          hint: AppLocalizations.of(context)!.addAllergenField,
          items: allergens.entries.map((a) => a.key).toList(),
          displayStringForOption: (allergen) => allergen.name,
          onSelectionChanged: (selectedList) {
            ref
                .read(selectedAllergensControllerProvider.notifier)
                .setSelected(selectedList);
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error loading allergens: $error'),
    );
  }
}
