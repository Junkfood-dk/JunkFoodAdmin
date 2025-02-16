import 'package:chefapp/data/database_provider.dart';
import 'package:chefapp/domain/model/rating_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'ratings_repository.g.dart';

class RatingStats {
  final double average;
  final int count;
  
  const RatingStats(this.average, this.count);
}

class RatingsRepository {
  SupabaseClient database;

  RatingsRepository({required this.database});

  Future<List<RatingModel>> loadRatings(int dishId) async {
    return await database
        .from('Ratings')
        .select()
        .eq('dish_id', dishId)
        .then(
          (rows) => rows
              .map((json) => RatingModel.fromJson(json))
              .toList(),
        );
  }

  Future<RatingStats> getDishRatingStats(int dishId) async {
    final result = await database
        .from('Ratings')
        .select('rating')
        .eq('dish_id', dishId);
    
    if (result.isEmpty) return const RatingStats(0.0, 0);
    
    final ratings = result.map((r) => r['rating'] as int).toList();
    final average = ratings.reduce((a, b) => a + b) / ratings.length;
    return RatingStats(average, ratings.length);
  }
}

@riverpod
RatingsRepository ratingsRepository(RatingsRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  return RatingsRepository(database: database);
}
