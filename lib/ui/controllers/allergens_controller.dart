import 'package:chefapp/data/allergens_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/ui/controllers/selected_allergens_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergens_controller.g.dart';

@riverpod
class AllergensController extends _$AllergensController {
  @override
  Future<List<AllergenModel>> build() async {
    var repository = ref.read(allergensRepositoryProvider);
    return await repository.fetchAllergens();
  }

  Map<AllergenModel, bool> _copyWith(Map<AllergenModel, bool> oldMap) {
    Map<AllergenModel, bool> newMap = {};
    newMap.addAll(oldMap);
    return newMap;
  }

  void postNewAllergen(String allergenName) async {
    var repository = ref.read(allergensRepositoryProvider);
    var newAllergen = await repository.postNewAllergen(allergenName);
    var oldState =
        ref.read(selectedAllergensControllerProvider.notifier).state.value!;
    oldState[newAllergen] = false; //
    ref.read(selectedAllergensControllerProvider.notifier).state =
        AsyncData(_copyWith(oldState));
  }
}
