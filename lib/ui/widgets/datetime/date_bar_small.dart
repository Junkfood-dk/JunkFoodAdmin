import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/ui/widgets/datetime/date.dart';

class DateBarSmall extends ConsumerWidget {
  const DateBarSmall({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDate = ref.watch(Providers.appDate);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 18.0),
            onPressed: () {
              ref.read(Providers.appDate.notifier).setPreviousDate();
              ref
                  .read(dishOfTheDayControllerProvider.notifier)
                  .updateDishOfTheDay();
            },
          ),
          SizedBoxExt.sizedBoxWidth16,
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  pickDate(context, ref, appDate);
                },
                child: Date.small(date: appDate),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () {
                  pickDate(context, ref, appDate);
                },
              ),
            ],
          ),
          SizedBoxExt.sizedBoxWidth8,
          IconButton(
            icon: const Icon(Icons.arrow_forward, size: 18.0),
            onPressed: ref.read(Providers.appDate.notifier).isNextDateAllowed()
                ? () {
                    ref.read(Providers.appDate.notifier).setNextDate();
                    ref
                        .read(dishOfTheDayControllerProvider.notifier)
                        .updateDishOfTheDay();
                  }
                : null,
          ),
        ],
      ),
    );
  }

  void pickDate(BuildContext context, WidgetRef ref, DateTime appDate) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: Providers.firstAppDate,
      lastDate: Providers.lastAppDate,
      initialDate: appDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (date != null) {
      ref.read(Providers.appDate.notifier).setDate(date);
      ref.read(dishOfTheDayControllerProvider.notifier).updateDishOfTheDay();
    }
  }
}
