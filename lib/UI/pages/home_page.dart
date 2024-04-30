import 'package:chefapp/UI/Controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/UI/Widgets/dish_display_widget.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dishOfTheDay = ref.watch(dishOfTheDayControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homePageTitle),
          actions: const [LanguageDropdownWidget()],
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: switch (dishOfTheDay) {
          AsyncData(:final value) => SingleChildScrollView(
              child: Column(
                children: [
                  FlutterCarousel(
                    items: value
                        .map((dish) =>
                            Center(child: DishDisplayWidget(dish: dish)))
                        .toList(),
                    options: CarouselOptions(
                        height: MediaQuery.sizeOf(context).height * 0.6),
                  ),
                  TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PostDishPage()));
                        dishOfTheDay =
                            ref.watch(dishOfTheDayControllerProvider);
                      },
                      child: Text(AppLocalizations.of(context)!.postDishButton))
                ],
              ),
            ),
          AsyncError(:final error) => Text(error.toString()),
          _ => const CircularProgressIndicator()
        }));
  }
}
