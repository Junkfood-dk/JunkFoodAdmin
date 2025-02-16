import 'package:chefapp/extensions/date_time_ext.dart';

class CommentModel {
  int id;
  String text;
  DateTime date;

  CommentModel({required this.id, required this.text, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'comment_text': text,
      'comment_date': date.toSupaDate(),
    };
  }

  static CommentModel fromJson(Map<String, dynamic> input) {
    return CommentModel(
      id: input.containsKey('id')
          ? input['id']
          : throw Exception('Missing comment id'),
      text: input.containsKey('comment_text')
          ? input['comment_text']
          : throw Exception('Missing comment text'),
      date: input.containsKey('comment_date')
          ? DateTime.parse(input['comment_date'])
          : throw Exception('Missing comment date'),
    );
  }
}
