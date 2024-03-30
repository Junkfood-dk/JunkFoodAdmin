import 'package:chefapp/model/language.dart';
import 'package:chefapp/model/locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => PopupMenuButton<Language>(
          onSelected: (Language language) {
            localeModel.set(Locale(language.languageCode));
          },
          icon: const Icon(Icons.language),
          itemBuilder: (BuildContext context) {
            List<PopupMenuEntry<Language>> menuItems =
                Language.languageList().map((e) {
              return PopupMenuItem<Language>(value: e, child: Text(e.name));
            }).toList();

            return menuItems;
          }),
    );
  }
}
