import 'package:chefapp/data/database_provider.dart';
import 'package:chefapp/domain/model/comment_model.dart';
import 'package:chefapp/extensions/date_time_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'comments_repository.g.dart';

class CommentRepository {
  SupabaseClient database;

  CommentRepository({required this.database});

  Future<List<CommentModel>> loadComments([DateTime? date]) async {
    return await database
        .from('Comments')
        .select()
        .filter(
          'comment_date',
          'eq',
          date?.toSupaDate() ?? DateTime.now().toSupaDate(),
        )
        .then(
          (rows) => rows
              .map((json) => CommentModel.fromJson(json))
              .toList(),
        );
  }
}

@riverpod
CommentRepository commentRepository(CommentRepositoryRef ref) {
  return CommentRepository(database: ref.read(databaseProvider));
}
