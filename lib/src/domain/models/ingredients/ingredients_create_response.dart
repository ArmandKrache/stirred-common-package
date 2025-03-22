
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredient.dart';
import 'package:equatable/equatable.dart';

class IngredientCreateResponse extends Equatable {
  final Ingredient ingredient;


  const IngredientCreateResponse({
    required this.ingredient,
  });


  factory IngredientCreateResponse.fromMap(Map<String, dynamic> map) {
    return IngredientCreateResponse(
      ingredient: Ingredient.fromJson(map),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [ingredient];

}