import 'package:chefapp/Data/allergenes_repository.dart';
import 'package:chefapp/Domain/Model/allergen_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergenes_controller.g.dart';

@riverpod
class AllergenesController extends _$AllergenesController {
  @override
  Future<List<AllergenModel>> build() async {
    var repository = ref.read(allergenesRepositoryProvider);
    return await repository.fetchAllergenes();
  }

  void updateAllergenes() async {
    var repository = ref.read(allergenesRepositoryProvider);
    var allergenes = await repository.fetchAllergenes();
    for (var allergen in allergenes) {
      bool exists = false;
      for (var existingAllergen in state.value!) {
        if (allergen.name == existingAllergen.name) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        state.value!.add(allergen);
      }
    }
  }

  void postNewAllergen(String allergenName) {
    var repository = ref.read(allergenesRepositoryProvider);
    repository.postNewAllergen(allergenName);
  }
}
