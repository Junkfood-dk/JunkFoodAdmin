import 'package:chefapp/domain/model/allergen_model.dart';

abstract interface class IAllergensRepository {
  Future<List<AllergenModel>> fetchAllergens();
  Future<AllergenModel> postNewAllergen(String allergenName);
}
