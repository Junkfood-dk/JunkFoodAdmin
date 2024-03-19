import 'package:chefapp/components/create_new_dish_component.dart';
import 'package:chefapp/components/dish_display_component.dart';
import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:chefapp/model/locale.dart';
import 'package:chefapp/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

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
                future: state.hasDishesOfTheDay,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    if (!snapshot.data!) {
                      return const Column(
                        children: [
                          Text("No dish today"),
                          CreateNewDishComponent()
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.4),
                            child: FlutterCarousel(
                                items: state.dishesOfTheDay
                                    .map((dish) =>
                                        DishDisplayComponent(dish: dish))
                                    .toList(),
                                options: CarouselOptions()),
                          ),
                          const CreateNewDishComponent()
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
