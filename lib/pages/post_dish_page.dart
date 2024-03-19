import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/model/allergen_model.dart';
import 'package:chefapp/model/allergene_service.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chefapp/components/camera_component.dart';
import 'dart:io';
import 'package:camera/camera.dart';

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
          body: Center(
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
                  Consumer<_PostDishPageState>(
                    builder: (context, state, _) => Column(
                      children: [
                        SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () async {
                            // Initialize the camera
                            final cameras = await availableCameras();
                            final firstCamera = cameras.first;

                            // Navigate to the CameraPage and pass the camera
                            final XFile image =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CameraComponent(camera: firstCamera),
                              ),
                            );
                            print(image.path);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Color.fromARGB(
                                  255, 206, 33, 33), // Add border color here
                            ),
                          ),
                          child: Text('Add Picture From Camera'),
                        ),
                      ],
                    ),
                  ),
                  Consumer<AllergeneService>(
                    // Displaying allergenes from fetched from the DB
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
                    // Allergene chips
                    builder: (context, state, _) {
                      return Column(
                        children: [
                          Consumer<_PostDishPageState>(
                            builder: (context, postDishPageState, child) =>
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
                                postDishPageState.addAllergen(newAllergen);
                              },
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Consumer3<DishOfTheDayModel, _PostDishPageState,
                          AllergeneService>(
                      builder: (context, dishOfTheDayModel, state,
                              allergeneService, _) =>
                          TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  int id =
                                      await dishOfTheDayModel.postDishOfTheDay(
                                          state.title,
                                          state.description,
                                          state.calories,
                                          state.imageUrl,
                                          state.cameraImage);
                                  final selectedAllergens =
                                      state.getSelectedAllergens();
                                  for (var allergene in selectedAllergens) {
                                    allergeneService.addAllergeneToDish(
                                        allergene, id);
                                  }
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

class _PostDishPageState extends ChangeNotifier {
  String title = "";
  String description = "";
  int calories = 0;
  String imageUrl = "";
  XFile? cameraImage;
  List<AllergenModel> selectedAllergens = [];
  Map<AllergenModel, bool> allergenToggles = {};

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

  void setCameraImage(XFile? image) {
    cameraImage = image;
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

  void updateToggle(List<AllergenModel> allergenes) {
    allergenToggles = {};
    for (var allergen in allergenes) {
      allergenToggles[allergen] = false;
    }
  }
}
