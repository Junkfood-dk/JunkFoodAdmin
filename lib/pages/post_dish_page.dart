import 'package:chefapp/main.dart';
import 'package:chefapp/model/category_model.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
            title: const Text("Chef"),
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
                            decoration:
                                const InputDecoration(labelText: "Name"),
                            onChanged: (value) => state.setTitle(value),
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Description"),
                            onChanged: (value) => state.setDescription(value),
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Calories"),
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
                                return "Please enter a valid URL";
                              } else {
                                return null;
                              }
                            },
                            decoration:
                                const InputDecoration(labelText: "ImageURL"),
                            onChanged: (value) {
                              if (isValidUrl(value)) {
                                state.setImageUrl(value);
                              }
                            },
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) {
                        return Column(
                          children: state.categoryToggles.keys.map((categoryName) {
                            return CheckboxListTile(
                              title: Text(categoryName),
                              value: state.categoryToggles[categoryName],
                              onChanged: (bool? newValue) {
                                state.toggleCategory(categoryName);
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
                          FutureBuilder<List<CategoryModel>>(
                            future: state.fetchCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (!snapshot.hasData) {
                                return const Text("No categories available");
                              }
                              final categoryChips = state.selectedCategories
                                  .map((category) => Chip(
                                        label: Text(category.name),
                                        onDeleted: () =>
                                            state.removeCategory(category.name),
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
                              labelText: "Add New Category",
                              labelStyle: labelText,
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                state.saveNewCategory(value);
                                state.addCategory(value);
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
                                  final selectedCategories = state.getSelectedCategories();
                                  selectedCategories.addAll(state.selectedCategories.map((category) => category.name));
                                  dishOfTheDayModel.postDishOfTheDay(
                                      state.title,
                                      state.description,
                                      state.calories,
                                      state.imageUrl);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text("Submit")))
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

  void addCategory(String categoryName) {
    CategoryModel category = CategoryModel(name: categoryName);
    if (!selectedCategories.any((c) => c.name == categoryName)) {
      selectedCategories.add(category);
      notifyListeners();
    }
  }

  void removeCategory(String categoryName) {
    selectedCategories.removeWhere((category) => category.name == categoryName);
    notifyListeners();
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response =
          await supabase.from("Categories").select("category_name");

      final List<CategoryModel> categories = List<CategoryModel>.from(
          response.map((categoryData) =>
              CategoryModel.fromJson({'name': categoryData['category_name']})));

      return categories;
    } catch (error) {
      debugPrint("Error fetching categories: $error");
      return [];
    }
  }

  Future<void> saveNewCategory(String categoryName) async {
    final category = CategoryModel(name: categoryName);

    try {
      final response =
          await supabase.from("Categories").insert(category.toJson());

      if (response['error'] != null) {
        debugPrint("Error saving new category: ${response['error']}");
        throw Exception("Failed to save new category: ${response['error']}");
      } else {
        debugPrint("New category saved successfully");
        final data = response['data'];
        if (data != null && data is List && data.isNotEmpty) {
          selectedCategories.add(CategoryModel.fromJson(data[0]));
        }
        notifyListeners();
      }
    } catch (error) {
      debugPrint("Error saving new category: $error");
      throw Exception("Failed to save new category: $error");
    }
  }

  final Map<String, bool> categoryToggles = {
    "Vegan": false,
    "Fish": false,
    "Pork": false,
    "Beef": false,
  };

  void toggleCategory(String categoryName) {
    if (categoryToggles.containsKey(categoryName)) {
      categoryToggles[categoryName] = !categoryToggles[categoryName]!;
      notifyListeners();
    }
  }

  List<String> getSelectedCategories() {
    return categoryToggles.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();
  }
}
