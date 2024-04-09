import 'package:chefapp/UI/Controllers/allergenes_controller.dart';
import 'package:chefapp/UI/Controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/UI/Controllers/selected_allergenes_controller.dart';
import 'package:chefapp/UI/Widgets/dish_type_dropdown_widget.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
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
    var nameTextController = useTextEditingController();
    var descriptionTextController = useTextEditingController();
    var calorieCount = useState(0);
    var imageTextController = useTextEditingController();
    var selectedAllergenes = ref.watch(selectedAllergenesControllerProvider);
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
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.textFormLabelForName),
                  controller: nameTextController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .textFormLabelForDescription),
                  controller: descriptionTextController,
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
                  controller: imageTextController,
                ),
                Column(
                    children: switch (selectedAllergenes) {
                  AsyncData(:final value) => value.entries.map((entry) {
                      var key = entry.key;
                      return CheckboxListTile(
                        title: Text(key.name),
                        value: value[key],
                        onChanged: (bool? newValue) {
                          ref
                              .read(
                                  selectedAllergenesControllerProvider.notifier)
                              .setSelected(key);
                        },
                      );
                    }).toList(),
                  _ => [CircularProgressIndicator()]
                }),
                Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Add New Allergen",
                        labelStyle: labelText,
                      ),
                      controller: newAllergenTextController,
                      onFieldSubmitted: (value) async {
                        ref
                            .read(allergenesControllerProvider.notifier)
                            .postNewAllergen(value);
                        newAllergenTextController.clear();
                      },
                    ),
                  ],
                ),
                const DishTypeDropdownWidget(),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(dishOfTheDayControllerProvider.notifier)
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
        )));
  }

  bool isValidUrl(String protenitalUri) {
    Uri? uri = Uri.tryParse(protenitalUri);
    return uri != null && uri.isAbsolute;
  }
}
