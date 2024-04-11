import 'package:chefapp/Domain/model/allergen_model.dart';

abstract interface class IAllergenesRepository {
  Future<List<AllergenModel>> fetchAllergenes();
  Future<AllergenModel> postNewAllergen(String allergenName);
}
