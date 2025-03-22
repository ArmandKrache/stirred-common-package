import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/domain/models/categories.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredient_match.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String id,
    required String name,
    required String description,
    required String picture,
    @Default([]) List<IngredientMatch> matches,
    required Categories categories,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
