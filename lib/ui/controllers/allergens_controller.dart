import 'package:chefapp/data/allergens_repository.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergens_controller.g.dart';

@riverpod
class AllergensController extends _$AllergensController {
  @override
  Future<List<AllergenModel>> build() async {
    var repository = ref.watch(allergensRepositoryProvider);
    return await repository.fetchAllergens();
  }

  void postNewAllergen(String allergenName) async {
    final repository = ref.read(allergensRepositoryProvider);
    await repository.postNewAllergen(allergenName);
    ref.invalidate(allergensRepositoryProvider);
  }
}
