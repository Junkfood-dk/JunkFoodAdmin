import 'package:chefapp/data/comments_repository.dart';
import 'package:chefapp/domain/model/comment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'comments_controller.g.dart';

@riverpod
class CommentsController extends _$CommentsController {
  @override
  Future<List<CommentModel>> build() async {
    var repository = ref.read(commentRepositoryProvider);
    final comments = repository.loadComments();
    return comments;
  }
}
