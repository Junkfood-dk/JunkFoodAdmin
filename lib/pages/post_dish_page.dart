import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/model/allergen_model.dart';
import 'package:chefapp/model/allergene_service.dart';
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
                  Consumer<AllergeneService>(
                    builder: (context, state, _) {
                      return Column(
                        children: state.allergenes.keys.map((allergenName) {
                          return CheckboxListTile(
                            title: Text(allergenName),
                            value: state.allergenes[allergenName],
                            onChanged: (bool? newValue) {
                              state.toggleAllergen(allergenName);
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Consumer<AllergeneService>(
                    builder: (context, state, _) {
                      return Column(
                        children: [
                          Consumer<PostDishPageState>(
                            builder: (context, value, child) =>
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
                                final categoryChips = value.selectedAllergens
                                    .map((allergen) => Chip(
                                          label: Text(allergen.name),
                                          onDeleted: () => value
                                              .removeAllergen(allergen.name),
                                        ))
                                    .toList();
                                return Wrap(
                                  spacing: 8.0,
                                  children: categoryChips,
                                );
                              },
                            ),
                          ),
                          Consumer<PostDishPageState>(
                            builder: (context, postDishPageState, child) =>
                                TextFormField(
                              decoration: InputDecoration(
                                labelText: "Add New Allergen",
                                labelStyle: labelText,
                              ),
                              onFieldSubmitted: (value) {
                                state.saveNewAllergen(value);
                                postDishPageState.addAllergen(value);
                              },
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Consumer3<DishOfTheDayModel, PostDishPageState,
                          AllergeneService>(
                      builder: (context, dishOfTheDayModel, state,
                              allergeneService, _) =>
                          TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final selectedAllergens =
                                      allergeneService.getSelectedAllergens();
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
}
