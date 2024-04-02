import 'package:chefapp/Data/allergenes_repository.dart';
import 'package:chefapp/Domain/Model/allergen_model.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_allergenes_controller.g.dart';

@riverpod
class SelectedAllergenesController extends _$SelectedAllergenesController {
  @override
  Map<AllergenModel, bool> build() {
    var repository = ref.read(allergenesRepositoryProvider);
    Map<AllergenModel, bool> map = {};
    repository.fetchAllergenes().then(
        (allergenes) => allergenes.map((allergen) => map[allergen] = false));
    return map;
  }

  List<AllergenModel> getAllSelectedAllergenes() {
    List<AllergenModel> selectedAllergenes = [];
    state.forEach((allergen, selected) {
      if (selected) {
        selectedAllergenes.add(allergen);
      }
    });
    return selectedAllergenes;
  }
}
