import 'package:chefapp/ui/controllers/authentication_controller.dart';
import 'package:chefapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/ui/widgets/datetime/date_bar.dart';
import 'package:chefapp/ui/widgets/dish_display_widget.dart';
import 'package:chefapp/ui/widgets/language_dropdown_widget.dart';
import 'package:chefapp/ui/pages/post_dish_page.dart';
import 'package:chefapp/ui/pages/splash_page.dart';
import 'package:chefapp/utilities/widgets/gradiant_button_widget.dart';
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
        body: switch (dishOfTheDay) {
          AsyncData(:final value) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const DateBar(),
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
        });
  }
}
