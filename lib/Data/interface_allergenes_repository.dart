import 'package:chefapp/Domain/Model/allergen_model.dart';

abstract interface class IAllergenesRepository {
  Future<List<AllergenModel>> fetchAllergenes();
  void postNewAllergen(String allergenName);
}