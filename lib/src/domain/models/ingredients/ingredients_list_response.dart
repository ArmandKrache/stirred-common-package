
import 'package:stirred_common_domain/src/domain/models/categories.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredient.dart';
import 'package:equatable/equatable.dart';

class IngredientsListResponse extends Equatable {
  final List<Ingredient> ingredients;


  const IngredientsListResponse({
    required this.ingredients,
  });


  factory IngredientsListResponse.fromMap(Map<String, dynamic> map) {
    return IngredientsListResponse(
      ingredients: List<Ingredient>.from((map['results'] ?? []).map<dynamic>((element) {
        return Ingredient.fromMap(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [ingredients];

}