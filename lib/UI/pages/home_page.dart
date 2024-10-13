import 'package:chefapp/UI/Controllers/authentication_controller.dart';
import 'package:chefapp/UI/Controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/UI/Widgets/dish_display_widget.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';
import 'package:chefapp/UI/pages/splash_page.dart';
import 'package:chefapp/Utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishOfTheDay = ref.watch(dishOfTheDayControllerProvider);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.logout),
            tooltip: AppLocalizations.of(context)!.signout,
            onPressed: () {
              ref.watch(authenticationControllerProvider.notifier).signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SplashPage(),
              ));
            },
          ),
          title: Text(AppLocalizations.of(context)!.homePageTitle),
          centerTitle: true,
          actions: const [LanguageDropdownWidget()],
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
                    options: FlutterCarouselOptions(
                        height: MediaQuery.sizeOf(context).height * 0.6),
                  ),
                  GradiantButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PostDishPage()));
                        await ref
                            .read(dishOfTheDayControllerProvider.notifier)
                            .updateDishOfTheDay();
                      },
                      child:
                          Text(AppLocalizations.of(context)!.postDishButton)),
                ],
              ),
            ),
          AsyncError(:final error) => Text(error.toString()),
          _ => const CircularProgressIndicator()
        }));
  }
}
