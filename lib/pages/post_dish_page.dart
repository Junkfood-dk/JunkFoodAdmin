import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/model/allergen_model.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _formKey = GlobalKey<FormState>();

class PostDishPage extends StatelessWidget {
  const PostDishPage({super.key});

  final TextStyle labelText =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostDishPageState(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.addDishPageTitle),
            actions: [LanguageDropdown()],
          ),
          body: Center(
              child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .textFormLabelForName),
                            onChanged: (value) => state.setTitle(value),
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .textFormLabelForDescription),
                            onChanged: (value) => state.setDescription(value),
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .textFormLabelForCalories),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) =>
                                state.setCalories(int.parse(value)),
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            validator: (value) {
                              if (!isValidUrl(value!)) {
                                return AppLocalizations.of(context)!
                                    .invalidURLPromt;
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                label: Text(AppLocalizations.of(context)!
                                    .textFormLabelForImageURL)),
                            onChanged: (value) {
                              if (isValidUrl(value)) {
                                state.setImageUrl(value);
                              }
                            },
                          )),
                  Consumer<PostDishPageState>(
                    builder: (context, state, _) {
                      return Column(
                        children:
                            state.allergenToggles.keys.map((allergenName) {
                          return CheckboxListTile(
                            title: Text(allergenName),
                            value: state.allergenToggles[allergenName],
                            onChanged: (bool? newValue) {
                              state.toggleAllergen(allergenName);
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Consumer<PostDishPageState>(
                    builder: (context, state, _) {
                      return Column(
                        children: [
                          FutureBuilder<List<AllergenModel>>(
                            future: state.fetchAllergens(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (!snapshot.hasData) {
                                return const Text("No allergens available");
                              }
                              final categoryChips = state.selectedAllergens
                                  .map((allergen) => Chip(
                                        label: Text(allergen.name),
                                        onDeleted: () =>
                                            state.removeAllergen(allergen.name),
                                      ))
                                  .toList();
                              return Wrap(
                                spacing: 8.0,
                                children: categoryChips,
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Add New Allergen",
                              labelStyle: labelText,
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                state.saveNewAllergen(value);
                                state.addAllergen(value);
                              }
                            },
                          )
                        ],
                      );
                    },
                  ),
                  Consumer2<DishOfTheDayModel, PostDishPageState>(
                      builder: (context, dishOfTheDayModel, state, _) =>
                          TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final selectedAllergens =
                                      state.getSelectedAllergens();
                                  selectedAllergens.addAll(state
                                      .selectedAllergens
                                      .map((allergen) => allergen.name));
                                  dishOfTheDayModel.postDishOfTheDay(
                                      state.title,
                                      state.description,
                                      state.calories,
                                      state.imageUrl);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.submitButton)))
                ],
              ),
            ),
          ))),
    );
  }

  bool isValidUrl(String protenitalUri) {
    Uri? uri = Uri.tryParse(protenitalUri);
    return uri != null && uri.isAbsolute;
  }
}

class PostDishPageState extends ChangeNotifier {
  String title = "";
  String description = "";
  int calories = 0;
  String imageUrl = "";
  List<AllergenModel> selectedAllergens = [];
  void setTitle(String newValue) {
    title = newValue;
    notifyListeners();
  }

  void setDescription(String newValue) {
    description = newValue;
    notifyListeners();
  }

  void setCalories(int newValue) {
    if (newValue >= 0) {
      calories = newValue;
      notifyListeners();
    } else {
      throw Exception("Calory count can't be negative");
    }
  }

  void setImageUrl(String newValue) {
    imageUrl = newValue;
    notifyListeners();
  }
  
  void toggleAllergen(String allergenName) {
    if (allergenToggles.containsKey(allergenName)) {
      allergenToggles[allergenName] = !allergenToggles[allergenName]!;
      notifyListeners();
    }
  }


void addAllergen(String allergenName) {
  AllergenModel allergen = AllergenModel(name: allergenName);
  if (!selectedAllergens.any((a) => a.name == allergenName)) {
    selectedAllergens.add(allergen);
    notifyListeners();
  }
}

void removeAllergen(String allergenName) {
  selectedAllergens.removeWhere((allergen) => allergen.name == allergenName);
  notifyListeners();
}

Future<List<AllergenModel>> fetchAllergens() async {
  try {
    final response = await supabase.from("Allergens").select("allergen_name");

    final List<AllergenModel> allergens = List<AllergenModel>.from(response.map(
        (allergenData) =>
            AllergenModel.fromJson({'name': allergenData['allergen_name']})));

    return allergens;
  } catch (error) {
    debugPrint("Error fetching allergens: $error");
    return [];
  }
}

Future<void> saveNewAllergen(String allergenName) async {
  final allergen = AllergenModel(name: allergenName);

  try {
    final response = await supabase.from("Allergens").insert(allergen.toJson());

    if (response['error'] != null) {
      debugPrint("Error saving new allergen: ${response['error']}");
      throw Exception("Failed to save new allergen: ${response['error']}");
    } else {
      debugPrint("New allergen saved successfully");
      final data = response['data'];
      if (data != null && data is List && data.isNotEmpty) {
        selectedAllergens.add(AllergenModel.fromJson(data[0]));
      }
      notifyListeners();
    }
  } catch (error) {
    debugPrint("Error saving new allergen: $error");
    throw Exception("Failed to save new allergen: $error");
  }
}

final Map<String, bool> allergenToggles = {
  "Gluten": false,
  "Fish": false,
  "Nuts": false,
  "Lactose": false,
};



List<String> getSelectedAllergens() {
  return allergenToggles.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();
}
}
