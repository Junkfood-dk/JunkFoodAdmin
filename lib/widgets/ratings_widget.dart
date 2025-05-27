import 'package:chefapp/extensions/sized_box_ext.dart';
import 'package:chefapp/widgets/gradiant_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/data/ratings_repository.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';

class RatingsWidget extends ConsumerWidget {
  final int dishId;
  const RatingsWidget({super.key, required this.dishId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingsRepository = ref.watch(ratingsRepositoryProvider);

    return FutureBuilder<RatingStats>(
      future: ratingsRepository.getDishRatingStats(dishId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            AppLocalizations.of(context)!.noRatings,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          );
        }

        final stats = snapshot.data ?? const RatingStats(0.0, 0);
        final rating = stats.average;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: stats.count > 0 && rating >= 0 && rating < 0.5
                      ? 1.0
                      : 0.3,
                  child: const GradiantWrapper(
                    child:
                        Icon(Icons.sentiment_dissatisfied_rounded, size: 48.0),
                  ),
                ),
                SizedBoxExt.sizedBoxWidth8,
                Opacity(
                  opacity: rating >= 0.5 && rating < 1.0 ? 1.0 : 0.3,
                  child: const GradiantWrapper(
                    child: Icon(Icons.sentiment_neutral_rounded, size: 48.0),
                  ),
                ),
                SizedBoxExt.sizedBoxWidth8,
                Opacity(
                  opacity: rating >= 1.0 && rating <= 2.0 ? 1.0 : 0.3,
                  child: const GradiantWrapper(
                    child:
                        Icon(Icons.sentiment_satisfied_alt_rounded, size: 48.0),
                  ),
                ),
              ],
            ),
            SizedBoxExt.sizedBoxHeight4,
            Text(
              AppLocalizations.of(context)!.numberOfRatings(stats.count),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}
