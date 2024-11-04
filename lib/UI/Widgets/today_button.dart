import 'package:chefapp/providers/providers.dart';
import 'package:chefapp/ui/widgets/datetime/date.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayButton extends ConsumerWidget {
  const TodayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: () =>
            ref.read(Providers.appDate.notifier).setDate(DateTime.now()),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.today.toUpperCase()),
            Date.small(date: DateTime.now()),
          ],
        ));
  }
}
