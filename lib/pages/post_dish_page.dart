import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/main.dart';
import 'package:chefapp/model/allergen_model.dart';
import 'package:chefapp/model/allergen_service.dart';
import 'package:chefapp/model/category_model.dart';
import 'package:chefapp/model/category_service.dart';
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
      create: (context) => _PostDishPageState(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.addDishPageTitle),
            actions: [LanguageDropdown()],
          ),
          body: SingleChildScrollView(
            child: Center(
            child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Consumer<_PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .textFormLabelForName),
                            onChanged: (value) => state.setTitle(value),
                          )),
                  Consumer<_PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .textFormLabelForDescription),
                            onChanged: (value) => state.setDescription(value),
                          )),
                  Consumer<_PostDishPageState>(
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
                  Consumer<_PostDishPageState>(
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
                    builder: (context, allergeneService, _) {
                      return FutureBuilder(
                        future: allergeneService.fetchAllergens(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return Consumer<_PostDishPageState>(
                            builder: (context, state, child) {
                              if (state.allergenToggles.length !=
                              allergeneService.allergenes.length) {
                                state.updateToggle(allergeneService.allergenes);
                              }
                              return Column(
                                children: 
                                  state.allergenToggles.entries.map((entry) {
                                    var key = entry.key;
                                    return CheckboxListTile(
                                      title: Text(key.name),
                                      value: state.allergenToggles[key],
                                      onChanged: (bool? newValue) {
                                        state.toggleAllergen(key);
                                      },
                                    );
                                  }).toList(),
                              );
                            });
                        });
                    },
                  ),
                  Consumer<AllergeneService>(
                    builder: (context, state, _) {
                      return Column(
                        children: [
                          Consumer<_PostDishPageState>(
                            builder: (context, postDishState, child) => 
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Add New Allergen",
                                labelStyle: labelText,
                              ),
                              onFieldSubmitted: (value) async {
                                debugPrint("Saving ${value}");
                                AllergenModel newAllergen = 
                                  await state.saveNewAllergen(value);
                                  debugPrint("Saved ${newAllergen.name}");
                                  postDishState.addAllergen(newAllergen);
                              },
                            ),
                          )
                        ],
                      );
                    } ,
                  ),
                  Consumer<CategoryService>(
                      builder: (context, categoryService, _) {
                        return FutureBuilder(
                          future: categoryService.fetchCategories(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            return Consumer<_PostDishPageState>(
                              builder: (context, state, child) {
                                if (state.categoryToggles.length !=
                                  categoryService.categories.length) {
                                    state.updateToggleCategory(categoryService.categories);
                                  }
                                return Column(
                                  children: 
                                    state.categoryToggles.entries.map((entry) {
                                      var key = entry.key;
                                      return CheckboxListTile(
                                        title: Text(key.name),
                                        value: state.categoryToggles[key],
                                        onChanged: (bool? newValue) {
                                          state.toggleCategory(key);
                                        },
                                      );
                                    }).toList(),
                                );
                              } ,
                            );
                          },
                        );
                      },
                    ),
                  Consumer<CategoryService>(
                    builder: (context, state, _) {
                      return Column(
                        children: [
                          Consumer<_PostDishPageState>(
                            builder: (context, postDishPageState, child) => 
                              TextFormField(
                                decoration: InputDecoration (
                                  labelText: AppLocalizations.of(context)!.addCategoryField,
                                  labelStyle: labelText, 
                                ),
                                 onFieldSubmitted: (value) async {
                                debugPrint("Saving ${value}");
                                CategoryModel newCategory =
                                    await state.saveNewCategory(value);
                                debugPrint("Saved ${newCategory.name}");
                                postDishPageState.addCategory(newCategory);
                                },
                              ),
                          )
                        ],
                      );
                    },
                  ),
                  Consumer4<DishOfTheDayModel,_PostDishPageState,AllergeneService,CategoryService>(
                    builder: (context, dishOfTheDayModel, state, allergenService,categoryService, _) => 
                      TextButton(
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            int id = 
                              await dishOfTheDayModel.postDishOfTheDay(
                                state.title,
                                state.description,
                                state.calories,
                                state.imageUrl,
                              );
                            final selectedAllergens = 
                              state.getSelectedAllergens();
                            for (var allergene in selectedAllergens) {
                              allergenService.addAllergeneToDish(allergene, id);
                            }
                            final selectedCategories = 
                              state.getSelectedCategories();
                            for (var category in selectedCategories) {
                              categoryService.addCategoryToDish(category, id);
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.submitButton),
                      ),
                  )
                ],
              ),
            ))),
          ),
    ));
  }

  bool isValidUrl(String protenitalUri) {
    Uri? uri = Uri.tryParse(protenitalUri);
    return uri != null && uri.isAbsolute;
  }
}

class _PostDishPageState extends ChangeNotifier {
  String title = "";
  String description = "";
  int calories = 0;
  String imageUrl = "";
  List<AllergenModel> selectedAllergens = [];
  Map<AllergenModel, bool> allergenToggles = {};
  List<CategoryModel> selectedCategories = [];
  Map<CategoryModel, bool> categoryToggles = {};

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

  void addAllergen(AllergenModel allergen) async {
    if (!selectedAllergens.any((a) => a.name == allergen.name)) {
      selectedAllergens.add(allergen);
      notifyListeners();
    }
  }

  void removeAllergen(String allergenName) {
    selectedAllergens.removeWhere((allergen) => allergen.name == allergenName);
    notifyListeners();
  }

  List<AllergenModel> getSelectedAllergens() {
    var list = selectedAllergens;
    list.addAll(allergenToggles.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList());
    return list;
  }

  void toggleAllergen(AllergenModel allergen) {
    if (allergenToggles.containsKey(allergen)) {
      allergenToggles[allergen] = !allergenToggles[allergen]!;
      notifyListeners();
    }
  }

  void updateToggle(List<AllergenModel> allergens) {
    allergenToggles = {};
    for (var allergen in allergens) {
      allergenToggles[allergen] = false;
    }
  }
 
  void addCategory(CategoryModel category) async {
    if (!selectedCategories.any((c) => c.name == category.name)) {
      selectedCategories.add(category);
      notifyListeners();
    }
  }

  void removeCategory(String categoryName) {
    selectedCategories.removeWhere((category) => category.name == categoryName);
    notifyListeners();
  }

  List<CategoryModel> getSelectedCategories() {
    var list = selectedCategories;
    list.addAll(categoryToggles.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList());
    return list;
  }

  void toggleCategory(CategoryModel category) {
    if (categoryToggles.containsKey(category)) {
      categoryToggles[category] = !categoryToggles[category]!;
      notifyListeners();
    }
  }

  void updateToggleCategory(List<CategoryModel> categories) {
    categoryToggles = {};
    for (var category in categories) {
      categoryToggles[category] = false;
    }
  }
}
