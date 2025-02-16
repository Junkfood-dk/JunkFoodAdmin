import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/extensions/date_time_ext.dart';
import 'package:chefapp/extensions/padding_ext.dart';
import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/controllers/authentication_controller.dart';
import 'package:chefapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/ui/widgets/datetime/date.dart';
import 'package:chefapp/ui/widgets/datetime/date_bar_small.dart';
import 'package:chefapp/ui/widgets/dish_display_widget.dart';
import 'package:chefapp/ui/widgets/language_dropdown_widget.dart';
import 'package:chefapp/ui/pages/post_dish_page.dart';
import 'package:chefapp/ui/pages/splash_page.dart';
import 'package:chefapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dishOfTheDay = ref.watch(dishOfTheDayControllerProvider);
    final date = ref.watch(Providers.appDate);

    if (!dishOfTheDay.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    _tabController.dispose();

    _tabController = TabController(
      length: dishOfTheDay.value?.length ?? 0,
      vsync: this,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          tooltip: AppLocalizations.of(context)!.signout,
          onPressed: () {
            ref.watch(authenticationControllerProvider.notifier).signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SplashPage(),
              ),
            );
          },
        ),
        title: Text(AppLocalizations.of(context)!.homePageTitle),
        centerTitle: true,
        actions: const [LanguageDropdownWidget()],
        bottom: dishOfTheDay.value!.length > 1
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Center(
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    dividerHeight: 0.0,
                    indicator: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE52E42),
                    ),
                    tabs: dishOfTheDay.value!.map((DishModel dish) {
                      return Tab(
                        child: SizedBox(
                          width: 8.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            : null,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return dishOfTheDay.when(
            data: (dishes) {
              if (dishes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.restaurant_menu, size: 64),
                      SizedBoxExt.sizedBoxHeight16,
                      Text(
                        'No dishes available for',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Date(date: date),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight * 0.8,
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: dishOfTheDay.value!.map((DishModel dish) {
                          return DishDisplayWidget(
                            dish: dish,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return const Text('Øv!');
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DateBarSmall(),
          if (date.isTodayOrAfter())
            Padding(
              padding: PaddingExt.paddingRight16,
              child: GradiantButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PostDishPage(),
                    ),
                  );
                  await ref
                      .read(dishOfTheDayControllerProvider.notifier)
                      .updateDishOfTheDay();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add),
                    SizedBoxExt.sizedBoxWidth8,
                    Text(AppLocalizations.of(context)!.postDishButton),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
