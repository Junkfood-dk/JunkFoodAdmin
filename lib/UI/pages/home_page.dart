import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homePageTitle),
          actions: const [LanguageDropdownWidget()],
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
