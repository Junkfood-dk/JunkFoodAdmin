import 'package:chefapp/data/allergens_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_allergens_controller.g.dart';

@riverpod
class SelectedAllergensController extends _$SelectedAllergensController {
  @override
  Future<Map<AllergenModel, bool>> build() async {
    var repository = ref.read(allergensRepositoryProvider);
    var allergens = await repository.fetchAllergens();
    final map = Map<AllergenModel, bool>.fromIterable(
      allergens,
      value: (_) => false,
    );
    return map;
  }

  List<AllergenModel> getAllSelectedAllergens() {
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
    final ids = selectedAllergens.map((allergen) => allergen.id).toList();
    state.value!.forEach((allergen, selected) {
      if (ids.contains(allergen.id)) {
        allergens.putIfAbsent(allergen, () => true);
      } else {
        allergens.putIfAbsent(allergen, () => false);
      }
    });
    state = AsyncData(allergens);
  }
}
