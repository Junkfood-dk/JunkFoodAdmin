import 'package:chefapp/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateNewDishComponent extends StatelessWidget {
  const CreateNewDishComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostDishPage(),
      )),
      child: Text(AppLocalizations.of(context)!.postDishButton),
    );
  }
}
