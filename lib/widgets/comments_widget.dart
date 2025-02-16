import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/data/comments_repository.dart';
import 'package:chefapp/domain/model/comment_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chefapp/extensions/sized_box_ext.dart';

class CommentsWidget extends ConsumerStatefulWidget {
  final DateTime? date;

  const CommentsWidget({super.key, this.date});

  @override
  ConsumerState<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends ConsumerState<CommentsWidget> {
  int _currentIndex = 0;
  List<CommentModel> _comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    final repository = ref.read(commentRepositoryProvider);
    final comments = await repository.loadComments(widget.date);
    setState(() {
      _comments = comments;
    });
  }

  void _nextComment() {
    if (_comments.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _comments.length;
    });
  }

  void _previousComment() {
    if (_comments.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex - 1 + _comments.length) % _comments.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_comments.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noComments,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _previousComment,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    _comments[_currentIndex].text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBoxExt.sizedBoxHeight8,
                  Text(
                    AppLocalizations.of(context)!.commentCount(
                      _currentIndex + 1,
                      _comments.length,
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _nextComment,
            ),
          ],
        ),
      ],
    );
  }
}
