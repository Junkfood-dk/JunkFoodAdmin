import 'package:chefapp/data/allergenes_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/UI/Controllers/selected_allergenes_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergenes_controller.g.dart';

@riverpod
class AllergenesController extends _$AllergenesController {
  @override
  Future<List<AllergenModel>> build() async {
    var repository = ref.read(allergenesRepositoryProvider);
    return await repository.fetchAllergenes();
  }

  Map<AllergenModel, bool> _copyWith(Map<AllergenModel, bool> oldMap) {
    Map<AllergenModel, bool> newMap = {};
    newMap.addAll(oldMap);
    return newMap;
  }

  void postNewAllergen(String allergenName) async {
    var repository = ref.read(allergenesRepositoryProvider);
    var newAllergen = await repository.postNewAllergen(allergenName);
    var oldState =
        ref.read(selectedAllergenesControllerProvider.notifier).state.value!;
    oldState[newAllergen] = false; //
    ref.read(selectedAllergenesControllerProvider.notifier).state =
        AsyncData(_copyWith(oldState));
  }
}
