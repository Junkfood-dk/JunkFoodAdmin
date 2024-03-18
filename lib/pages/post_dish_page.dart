import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/main.dart';
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
                  Consumer<CategoryService>(
                      builder: (context, categoryService, _) {
                        return FutureBuilder(
                          future: categoryService.fetchCategories(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            return Consumer<PostDishPageState>(
                              builder: (context, state, child) {
                                if (state.categoryToggles.length !=
                                  categoryService.categories.length) {
                                    state.updateToggle(categoryService.categories);
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
                          Consumer<PostDishPageState>(
                            builder: (context, postDishPageState, child) => 
                              TextFormField(
                                decoration: InputDecoration (
                                  labelText: "Add new Category",
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
                  Consumer3<DishOfTheDayModel,PostDishPageState,CategoryService>(
                    builder: (context, dishOfTheDayModel, state, categoryService, _) => 
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
                            final selectedCategories = 
                              state.getSelectedCategories();
                            for (var category in selectedCategories) {
                              categoryService.addCategoryToDish(category, id);
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Submit"),
                      ),
                  )
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

  void updateToggle(List<CategoryModel> categories) {
    categoryToggles = {};
    for (var category in categories) {
      categoryToggles[category] = false;
    }
  }
}
