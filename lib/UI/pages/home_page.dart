
import 'package:chefapp/Domain/dish_of_the_day_model.dart';
import 'package:chefapp/Domain/Model/locale.dart';
import 'package:chefapp/UI/components/dish_display_component.dart';
import 'package:chefapp/UI/components/language_dropdown_component.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homePageTitle),
          actions: [LanguageDropdown()],
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Consumer<DishOfTheDayModel>(builder: (context, state, _) {
            return FutureBuilder(
                future: state.hasDishOfTheDay,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    if (!snapshot.data!) {
                      return TextButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostDishPage(),
                        )),
                        child:
                            Text(AppLocalizations.of(context)!.postDishButton),
                      );
                    } else {
                      return Column(
                        children: [
                          Center(
                              child: DishDisplayComponent(
                                  dish: state.dishOfTheDay))
                        ],
                      );
                    }
                  }
                });
          }),
        ),
      ),
    );
  }
}
