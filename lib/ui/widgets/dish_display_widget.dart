import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/extensions/date_time_ext.dart';
import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DishDisplayWidget extends ConsumerWidget {
  final DishModel dish;
  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(Providers.appDate);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Column(
              children: [
                if (dish.dishType.type != 'No dish type')
                  Text(
                    dish.dishType.type,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                else
                  Text(
                    AppLocalizations.of(context)!.noDishType,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                SizedBoxExt.sizedBoxHeight16,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        dish.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Display placeholder or error message when image loading fails
                          return Image.asset('assets/images/missing.jpg');
                        },
                      ),
                    ),
                  ),
                ),
                SizedBoxExt.sizedBoxHeight16,
                if (dish.title != '')
                  Text(
                    dish.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                else
                  Text(AppLocalizations.of(context)!.noTitle),
                SizedBoxExt.sizedBoxHeight8,
                if (dish.description != '')
                  Text(dish.description)
                else
                  Text(AppLocalizations.of(context)!.noDescription),
                SizedBoxExt.sizedBoxHeight8,
                Text(
                  '${AppLocalizations.of(context)!.calories}: ${dish.calories}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBoxExt.sizedBoxHeight24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (date.isTodayOrAfter() && dish.id != null)
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFFE52E42)),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: () async {
                          final text =
                              AppLocalizations.of(context)!.existingDishRemoved;
                          final scaffoldMessenger =
                              ScaffoldMessenger.of(context);

                          final ok = await ref
                              .read(dishOfTheDayControllerProvider.notifier)
                              .removeFromMenu(dish.id!, date);
                          if (ok) {
                            scaffoldMessenger.showSnackBar(
                              SnackBar(content: Text(text)),
                            );
                            await ref
                                .read(dishOfTheDayControllerProvider.notifier)
                                .updateDishOfTheDay();
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!
                              .removeExistingDishButton,
                        ),
                      ),
                    if (!date.isToday() && dish.id != null) ...[
                      SizedBoxExt.sizedBoxWidth16,
                      GradiantButton(
                        onPressed: () async {
                          final text =
                              AppLocalizations.of(context)!.existingDishAdded;
                          final scaffoldMessenger =
                              ScaffoldMessenger.of(context);

                          final id = await ref
                              .read(dishOfTheDayControllerProvider.notifier)
                              .addToTodaysMenu(dish.id!);
                          if (id > 0) {
                            scaffoldMessenger.showSnackBar(
                              SnackBar(content: Text(text)),
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.addExistingDishButton,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
