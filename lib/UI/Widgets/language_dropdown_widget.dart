import 'package:chefapp/domain/model/language_model.dart';
import 'package:chefapp/ui/controllers/locale_controller.dart';
import 'package:chefapp/utilities/widgets/gradiant_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageDropdownWidget extends ConsumerWidget {
  const LanguageDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<LanguageModel>(
        onSelected: (LanguageModel language) {
          ref
              .read(localeControllerProvider.notifier)
              .set(Locale(language.languageCode));
        },
        icon: const PrimaryGradiantWidget(child: Icon(Icons.language)),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<LanguageModel>> menuItems =
              LanguageModel.languageList().map((e) {
            return PopupMenuItem<LanguageModel>(value: e, child: Text(e.name));
          }).toList();

          return menuItems;
        });
  }
}
