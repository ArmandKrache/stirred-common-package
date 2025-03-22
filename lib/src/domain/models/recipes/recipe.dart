import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipe_ingredient.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'preparation_time') required int preparationTime,
    required String difficulty,
    required List<String> instructions,
    required List<RecipeIngredient> ingredients,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);

}
