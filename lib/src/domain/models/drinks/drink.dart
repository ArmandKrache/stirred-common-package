import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/domain/models/categories/categories.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/models/rating/rating.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipe.dart';

part 'drink.freezed.dart';
part 'drink.g.dart';

@freezed
class Drink with _$Drink {
  const factory Drink({
    required String id,
    required String name,
    required String picture,
    String? description,
    Recipe? recipe,
    Profile? author,
    Glass? glass,
    Categories? categories,
    @JsonKey(name: 'average_rating') @Default(0.0) double averageRating,
    @Default([]) List<Rating> ratings,
    @JsonKey(name: 'ratings_count') @Default(0) int ratingsCount,
    @JsonKey(name: 'user_rating') Rating? userRating,
  }) = _Drink;

  factory Drink.fromJson(Map<String, dynamic> json) =>
      _$DrinkFromJson(json);
}