import 'package:chefapp/data/allergens_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_allergens_controller.g.dart';

@riverpod
class SelectedAllergensController extends _$SelectedAllergensController {
  @override
  Future<Map<AllergenModel, bool>> build() async {
    var repository = ref.read(allergensRepositoryProvider);
    var allergenes = await repository.fetchAllergens();
    return Map.fromIterable(
      allergenes,
      value: (_) => false,
    ); // maps all allergenes to a false value
  }

  List<AllergenModel> getAllSelectedAllergenes() {
    List<AllergenModel> selectedAllergenes = [];
    state.value!.forEach((allergen, selected) {
      if (selected) {
        selectedAllergenes.add(allergen);
      }
    });
    return selectedAllergenes;
  }

  void setSelected(List<AllergenModel> selectedAllergens) {
    Map<AllergenModel, bool> allergens = {};
    state.value!.forEach((allergen, selected) {
      allergens.putIfAbsent(
        allergen,
        () => selectedAllergens.contains(allergen),
      );
    });
    state = AsyncData(allergens);
  }

  void clearSelection() {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.map((key, value) => MapEntry(key, false)),
    );
  }
}
