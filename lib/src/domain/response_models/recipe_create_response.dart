
import 'package:stirred_common_domain/src/domain/models/recipes/recipe.dart';
import 'package:equatable/equatable.dart';

class RecipeCreateResponse extends Equatable {
  final Recipe recipe;


  const RecipeCreateResponse({
    required this.recipe,
  });


  factory RecipeCreateResponse.fromMap(Map<String, dynamic> map) {
    return RecipeCreateResponse(
      recipe: Recipe.fromJson(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [recipe];

}