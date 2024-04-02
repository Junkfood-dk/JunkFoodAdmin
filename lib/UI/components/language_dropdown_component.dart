import 'package:chefapp/Domain/Model/language_model.dart';
import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageDropdown extends ConsumerWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<LanguageModel>(
        onSelected: (LanguageModel language) {
          ref
              .read(localeControllerProvider.notifier)
              .set(Locale(language.languageCode));
        },
        icon: const Icon(Icons.language),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<LanguageModel>> menuItems =
              LanguageModel.languageList().map((e) {
            return PopupMenuItem<LanguageModel>(value: e, child: Text(e.name));
          }).toList();

          return menuItems;
        });
  }
}
