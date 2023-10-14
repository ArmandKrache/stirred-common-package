
import 'package:stirred_common_domain/src/domain/models/recipes/recipe.dart';
import 'package:stirred_common_domain/src/domain/models/categories.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredient.dart';
import 'package:equatable/equatable.dart';

class RecipesListResponse extends Equatable {
  final List<Recipe> recipes;


  const RecipesListResponse({
    required this.recipes,
  });


  factory RecipesListResponse.fromMap(Map<String, dynamic> map) {
    return RecipesListResponse(
      recipes: List<Recipe>.from((map['results'] ?? []).map<dynamic>((element) {
        return Recipe.fromMap(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [recipes];

}