import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chefapp/domain/model/allergen_model.dart';
import 'package:chefapp/domain/model/category_model.dart';
import 'package:chefapp/UI/Controllers/allergenes_controller.dart';
import 'package:chefapp/UI/Controllers/categories_controller.dart';
import 'package:chefapp/UI/Controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/UI/Controllers/selected_allergenes_controller.dart';
import 'package:chefapp/UI/Controllers/selected_categories_controller.dart';
import 'package:chefapp/UI/Widgets/camera_widget.dart';
import 'package:chefapp/UI/Widgets/dish_type_dropdown_widget.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:chefapp/UI/Widgets/mutable_checkbox_widget.dart';
import 'package:chefapp/Utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _formKey = GlobalKey<FormState>();

class PostDishPage extends HookConsumerWidget {
  const PostDishPage({super.key});

  final TextStyle labelText =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newAllergenTextController = useTextEditingController();
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
          selection: TextSelection.fromPosition(TextPosition(
              offset: min(cursorPosition, capitalizedValue.length))));
    });

    var newCategoryTextController = useTextEditingController();
    var nameTextController = useTextEditingController();
    var descriptionTextController = useTextEditingController();
    var calorieCount = useState(0);
    var imageTextController = useTextEditingController();
    var selectedAllergenes = ref.watch(selectedAllergenesControllerProvider);
    var selectedCategories = ref.watch(selectedCategoriesControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addDishPageTitle),
          actions: const [LanguageDropdownWidget()],
        ),
        body: Center(
            child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    key: const Key("titleField"),
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.textFormLabelForName),
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
                          selection: TextSelection.fromPosition(TextPosition(
                              offset: min(
                                  cursorPosition, capitalizedValue.length))));
                    },
                  ),
                  TextFormField(
                    key: const Key("descriptionField"),
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .textFormLabelForDescription),
                    controller: descriptionTextController,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      String capitalizedValue = value.replaceAllMapped(
                          RegExp(r'(?<=(?:^|[.!?]\s))\p{L}', unicode: true),
                          (match) => match.group(0)!.toUpperCase());
                      int cursorPosition =
                          descriptionTextController.selection.baseOffset;
                      descriptionTextController.value = TextEditingValue(
                          text: capitalizedValue,
                          selection: TextSelection.fromPosition(TextPosition(
                              offset: min(
                                  cursorPosition, capitalizedValue.length))));
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                            .textFormLabelForCalories),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) =>
                        calorieCount.value = int.tryParse(value) ?? 0,
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
                          label: Text(AppLocalizations.of(context)!
                              .textFormLabelForImageURL)),
                      controller: imageTextController),
                  SizedBox(height: 10),
                  GradiantButton(
                    onPressed: () async {
                      // Navigate to the CameraPage and pass the camera
                      final XFile image = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CameraWidget(),
                        ),
                      );
                      imageTextController.text = image.path;
                    },
                    child: Text(AppLocalizations.of(context)!.takePictureLabel),
                  ),
                  MutableCheckboxWidget<AllergenModel>(
                      map: selectedAllergenes,
                      onSelected: ref
                          .read(selectedAllergenesControllerProvider.notifier)
                          .setSelected,
                      labelText: "Add allergenes",
                      textController: newAllergenTextController,
                      postNew: ref
                          .read(allergenesControllerProvider.notifier)
                          .postNewAllergen,
                      labelStyle: labelText),
                  MutableCheckboxWidget<CategoryModel>(
                      map: selectedCategories,
                      onSelected: ref
                          .read(selectedCategoriesControllerProvider.notifier)
                          .setSelected,
                      labelText: "Add category",
                      textController: newCategoryTextController,
                      postNew: ref
                          .read(categoriesControllerProvider.notifier)
                          .postNewCategory,
                      labelStyle: labelText),
                  const DishTypeDropdownWidget(),
                  SizedBox(height: 10),
                  GradiantButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .watch(dishOfTheDayControllerProvider.notifier)
                              .postDishOfTheDay(
                                  nameTextController.text,
                                  descriptionTextController.text,
                                  calorieCount.value,
                                  imageTextController.text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.submitButton))
                ],
              ),
            ),
          ),
        )));
  }

  bool isValidUrl(String protenitalUri) {
    Uri? uri = Uri.tryParse(protenitalUri);
    return uri != null && uri.isAbsolute;
  }
}
