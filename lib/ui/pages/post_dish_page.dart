import 'dart:math';

import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/domain/model/category_model.dart';
import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/ui/controllers/selected_allergens_controller.dart';
import 'package:chefapp/ui/controllers/selected_categories_controller.dart';
import 'package:chefapp/ui/widgets/camera_widget.dart';
import 'package:chefapp/ui/widgets/dish_type_dropdown_widget.dart';
import 'package:chefapp/ui/widgets/language_dropdown_widget.dart';
import 'package:chefapp/ui/widgets/multiple_select_dropdown.dart';
import 'package:chefapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _formKey = GlobalKey<FormState>();

class PostDishPage extends ConsumerStatefulWidget {
  const PostDishPage({super.key});

  @override
  ConsumerState<PostDishPage> createState() => _PostDishPageState();
}

class _PostDishPageState extends ConsumerState<PostDishPage> {
  late final TextEditingController newAllergenTextController;
  late final TextEditingController nameTextController;
  late final TextEditingController descriptionTextController;
  late final TextEditingController calorieCountController;
  late final TextEditingController imageTextController;
  String cameraBlobUrl = '';
  final ImagePicker picker = ImagePicker();

  final TextStyle labelText = const TextStyle(color: Colors.black54);

  @override
  void initState() {
    super.initState();
    newAllergenTextController = TextEditingController();
    newAllergenTextController.addListener(() {
      final text = newAllergenTextController.text;
      String capitalizedValue = text.replaceAllMapped(
          RegExp(r'(?<=^|\P{L})\p{L}', unicode: true), (match) {
        String matchedWord = match.group(0)!;
        if (matchedWord.isNotEmpty) {
          return matchedWord[0].toUpperCase() +
              matchedWord.substring(1).toLowerCase();
        }
        return matchedWord;
      });
      int cursorPosition = newAllergenTextController.selection.baseOffset;
      newAllergenTextController.value = TextEditingValue(
        text: capitalizedValue,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: min(cursorPosition, capitalizedValue.length),
          ),
        ),
      );
    });
    nameTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    calorieCountController = TextEditingController();
    imageTextController = TextEditingController();
  }

  @override
  void dispose() {
    newAllergenTextController.dispose();
    nameTextController.dispose();
    descriptionTextController.dispose();
    calorieCountController.dispose();
    imageTextController.dispose();
    super.dispose();
  }

  void setCameraBlobUrl(String url) {
    setState(() {
      cameraBlobUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedAllergens = ref.watch(selectedAllergensControllerProvider);
    var selectedCategories = ref.watch(selectedCategoriesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDishPageTitle),
        actions: const [LanguageDropdownWidget()],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBoxExt.sizedBoxHeight24,
                  if (imageTextController.text != '')
                    Stack(
                      children: [
                        Center(
                          child: Image.network(
                            imageTextController.text,
                            width: 400.0,
                            height: 300.0,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const CircularProgressIndicator();
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text('Error loading image'),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              imageTextController.text = '';
                              setCameraBlobUrl('');
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                  if (imageTextController.text == '')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (image != null) {
                              imageTextController.text = image.path;
                              cameraBlobUrl = image.path;
                            }
                          },
                          child: Image.asset(
                            width: 200.0,
                            height: 150.0,
                            'assets/images/file_picker.png',
                          ),
                        ),
                        SizedBoxExt.sizedBoxWidth16,
                        GestureDetector(
                          onTap: () async {
                            // Navigate to the CameraPage and pass the camera
                            final XFile image =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CameraWidget(),
                              ),
                            );
                            imageTextController.text = image.path;
                            cameraBlobUrl = image.path;
                          },
                          child: Image.asset(
                            width: 200.0,
                            height: 150.0,
                            'assets/images/camera_picker.png',
                          ),
                        ),
                      ],
                    ),
                  SizedBoxExt.sizedBoxHeight24,
                  TextFormField(
                    key: const Key('titleField'),
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.textFormLabelForName,
                    ),
                    controller: nameTextController,
                    onChanged: (value) {
                      String capitalizedValue = value.replaceAllMapped(
                          RegExp(r'(?<=^|\P{L})\p{L}', unicode: true), (match) {
                        String matchedWord = match.group(0)!;
                        if (matchedWord.isNotEmpty) {
                          return matchedWord[0].toUpperCase() +
                              matchedWord.substring(1).toLowerCase();
                        }
                        return matchedWord;
                      });
                      int cursorPosition =
                          nameTextController.selection.baseOffset;
                      nameTextController.value = TextEditingValue(
                        text: capitalizedValue,
                        selection: TextSelection.fromPosition(
                          TextPosition(
                            offset: min(
                              cursorPosition,
                              capitalizedValue.length,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    key: const Key('descriptionField'),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .textFormLabelForDescription,
                    ),
                    controller: descriptionTextController,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      String capitalizedValue = value.replaceAllMapped(
                        RegExp(r'(?<=(?:^|[.!?]\s))\p{L}', unicode: true),
                        (match) => match.group(0)!.toUpperCase(),
                      );
                      int cursorPosition =
                          descriptionTextController.selection.baseOffset;
                      descriptionTextController.value = TextEditingValue(
                        text: capitalizedValue,
                        selection: TextSelection.fromPosition(
                          TextPosition(
                            offset: min(
                              cursorPosition,
                              capitalizedValue.length,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .textFormLabelForCalories,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: calorieCountController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!isValidUrl(value!)) {
                        return AppLocalizations.of(context)!.invalidURLPromt;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text(
                        AppLocalizations.of(context)!.textFormLabelForImageURL,
                      ),
                    ),
                    controller: imageTextController,
                    onEditingComplete: () =>
                        setCameraBlobUrl(imageTextController.text),
                    onChanged: (value) {
                      if (isValidUrl(value)) {
                        setCameraBlobUrl(imageTextController.text);
                      }
                    },
                  ),
                  SizedBoxExt.sizedBoxHeight16,
                  selectedAllergens.when(
                    data: (data) {
                      return MultiSelectDropdown<AllergenModel>(
                        hint: 'Select allergens',
                        displayStringForOption: (allergen) => allergen.name,
                        items: data.entries.map((a) => a.key).toList(),
                        onSelectionChanged: (list) {
                          ref
                              .read(
                                selectedAllergensControllerProvider.notifier,
                              )
                              .setSelected(list);
                        },
                      );
                    },
                    error: (o, s) {
                      return const Text('Allergens not available...');
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
                  SizedBoxExt.sizedBoxHeight16,
                  selectedCategories.when(
                    data: (data) {
                      return MultiSelectDropdown<CategoryModel>(
                        hint: 'Select categories',
                        displayStringForOption: (allergen) => allergen.name,
                        items: data.entries.map((a) => a.key).toList(),
                        onSelectionChanged: (list) {
                          ref
                              .read(
                                selectedCategoriesControllerProvider.notifier,
                              )
                              .setSelected(list);
                        },
                      );
                    },
                    error: (o, s) {
                      return const Text('Categories not available...');
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
                  SizedBoxExt.sizedBoxHeight16,
                  const DishTypeDropdownWidget(),
                  SizedBoxExt.sizedBoxHeight16,
                  GradiantButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final navigator = Navigator.of(context);

                        try {
                          final date = ref.watch(Providers.appDate);
                          await ref
                              .read(dishOfTheDayControllerProvider.notifier)
                              .postDishOfTheDay(
                                nameTextController.text,
                                descriptionTextController.text,
                                int.parse(calorieCountController.text),
                                imageTextController.text,
                                date,
                              );
                          navigator.pop();
                        } on Exception catch (e) {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.submitButton),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidUrl(String protenitalUri) {
    Uri? uri = Uri.tryParse(protenitalUri);
    return uri != null && uri.isAbsolute;
  }
}
