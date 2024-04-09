import 'package:chefapp/Data/allergenes_repository.dart';
import 'package:chefapp/Domain/model/allergen_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_allergenes_controller.g.dart';

@riverpod
class SelectedAllergenesController extends _$SelectedAllergenesController {
  @override
  Future<Map<AllergenModel, bool>> build() async {
    var repository = ref.read(allergenesRepositoryProvider);
    var allergenes = await repository.fetchAllergenes();
    return Map.fromIterable(allergenes,
        value: (_) => false); // maps all allergenes to a false value
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

  void setSelected(AllergenModel allergen) {
    state.value![allergen] = !state.value![allergen]!;
    state = AsyncData(Map.from(state.value!));
  }
}
