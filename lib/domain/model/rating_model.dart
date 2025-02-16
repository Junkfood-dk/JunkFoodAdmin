import 'package:chefapp/extensions/date_time_ext.dart';

class RatingModel {
  int id;
  int dishId;
  int rating;
  DateTime date;

  RatingModel({
    required this.id,
    required this.dishId,
    required this.rating,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'dish_id': dishId,
      'rating': rating,
      'rating_date': date.toSupaDate(),
    };
  }

  static RatingModel fromJson(Map<String, dynamic> input) {
    return RatingModel(
      id: input.containsKey('id')
          ? input['id']
          : throw Exception('Missing rating id'),
      dishId: input.containsKey('dish_id')
          ? input['dish_id']
          : throw Exception('Missing dish id'),
      rating: input.containsKey('rating')
          ? input['rating']
          : throw Exception('Missing rating value'),
      date: input.containsKey('rating_date')
          ? DateTime.parse(input['rating_date'])
          : throw Exception('Missing rating date'),
    );
  }
}
