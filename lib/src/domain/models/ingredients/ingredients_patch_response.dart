import 'package:stirred_common_domain/src/domain/models/ingredients/ingredient.dart';
import 'package:equatable/equatable.dart';

class IngredientPatchResponse extends Equatable {
  final Ingredient ingredient;


  const IngredientPatchResponse({
    required this.ingredient,
  });


  factory IngredientPatchResponse.fromMap(Map<String, dynamic> map) {
    return IngredientPatchResponse(
      ingredient: Ingredient.fromJson(map),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [ingredient];

}