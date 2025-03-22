import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_match.freezed.dart';
part 'ingredient_match.g.dart';

@freezed
class IngredientMatch with _$IngredientMatch {
  const factory IngredientMatch({
    required String id,
    required String name,
  }) = _IngredientMatch;

  factory IngredientMatch.fromJson(Map<String, dynamic> json) =>
      _$IngredientMatchFromJson(json);
}
