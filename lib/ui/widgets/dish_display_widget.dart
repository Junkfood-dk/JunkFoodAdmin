import 'package:chefapp/domain/model/dish_model.dart';
import 'package:chefapp/extensions/date_time_ext.dart';
import 'package:chefapp/extensions/padding_ext.dart';
import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:chefapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/widgets/comments_widget.dart';
import 'package:chefapp/widgets/ratings_widget.dart';

class DishDisplayWidget extends ConsumerWidget {
  final DishModel dish;
  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(Providers.appDate);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            Text(
              dish.description,
              textAlign: TextAlign.center,
            )
          else
            Text(AppLocalizations.of(context)!.noDescription),
          SizedBoxExt.sizedBoxHeight8,
          Text(
            AppLocalizations.of(context)!.calories,
          ),
          Text(
            dish.calories > 0
                ? '${dish.calories}'
                : AppLocalizations.of(context)!.noCalories,
          ),
          SizedBoxExt.sizedBoxHeight8,
          Text(
            AppLocalizations.of(context)!.allergens,
          ),
          SizedBoxExt.sizedBoxHeight8,
          dish.allergens.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dish.allergens.map((allergen) {
                    bool isLast = allergen == dish.allergens.last;
                    return Text(
                      allergen + (!isLast ? ' • ' : ''),
                    );
                  }).toList(),
                )
              : Text(AppLocalizations.of(context)!.noAllergens),
          SizedBoxExt.sizedBoxHeight8,
          const Text(
            'Categories',
          ),
          SizedBoxExt.sizedBoxHeight8,
          dish.categories.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dish.categories.map((category) {
                    bool isLast = category == dish.categories.last;
                    return Text(
                      category + (!isLast ? ' • ' : ''),
                    );
                  }).toList(),
                )
              : const Text('No categories'),
          SizedBoxExt.sizedBoxHeight24,
          const Divider(
            color: Color.fromARGB(255, 108, 70, 74),
          ),
          SizedBoxExt.sizedBoxHeight24,
          if (date.isTodayOrBefore()) ...[
            RatingsWidget(dishId: dish.id!),
            SizedBoxExt.sizedBoxHeight24,
            Padding(
              padding: PaddingExt.paddingHorizontal24,
              child: CommentsWidget(date: date),
            ),
            SizedBoxExt.sizedBoxHeight24,
            const Divider(
              color: Color.fromARGB(255, 108, 70, 74),
            ),
            SizedBoxExt.sizedBoxHeight24,
          ],
          if (dish.id != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (date.isTodayOrAfter())
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xFFE52E42)),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      final text =
                          AppLocalizations.of(context)!.existingDishRemoved;
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

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
                      AppLocalizations.of(context)!.removeExistingDishButton,
                    ),
                  ),
                if (!date.isToday()) ...[
                  SizedBoxExt.sizedBoxWidth16,
                  GradiantButton(
                    onPressed: () async {
                      final text =
                          AppLocalizations.of(context)!.existingDishAdded;
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

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
    );
  }
}
