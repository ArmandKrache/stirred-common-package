import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/domain/models/categories/categories.dart';
import 'package:stirred_common_domain/src/domain/models/rating/rating.dart';

part 'drink.freezed.dart';
part 'drink.g.dart';

@freezed
class Drink with _$Drink {
  const factory Drink({
    required String id,
    required String name,
    required String description,
    required String picture,
    required String recipe,
    required String author,
    required String glass,
    required Categories categories,
    @JsonKey(name: 'average_rating') @Default(0.0) double averageRating,
    @Default([]) List<Rating> ratings,
    @JsonKey(name: 'ratings_count') @Default(0) int ratingsCount,
    @JsonKey(name: 'user_rating') Rating? userRating,
  }) = _Drink;

  factory Drink.fromJson(Map<String, dynamic> json) =>
      _$DrinkFromJson(json);
}