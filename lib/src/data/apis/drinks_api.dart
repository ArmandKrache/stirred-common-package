import 'package:http/http.dart' show MultipartFile;
import 'package:stirred_common_domain/src/data/http/error_handling_client.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:stirred_common_domain/src/domain/response_models/drink_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/drink_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/drinks_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/glass_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/ingredients_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/ingredients_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/ingredients_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/glasses_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/glasses_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/rating_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/rating_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/recipe_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/recipe_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/recipes_list_response.dart';
import 'package:stirred_common_domain/src/utils/resources/result.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';

class DrinksApi {
  final ErrorHandlingClient _client;

  DrinksApi(this._client);

  /// Glasses
  Future<Result<GlassesListResponse, StirError>> getGlassesList() {
    return _client.get<GlassesListResponse>(
      '/glasses/',
      fromJson: GlassesListResponse.fromMap,
    );
  }

  Future<Result<GlassesListResponse, StirError>> searchGlasses({String? query}) {
    return _client.get<GlassesListResponse>(
      '/glasses/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: GlassesListResponse.fromMap,
    );
  }

  Future<Result<GlassesCreateResponse, StirError>> createGlass({
    required String name,
    required String description,
    required MultipartFile picture,
  }) {
    final fields = {
      'name': name,
      'description': description,
    };

    final files = {
      'picture': picture,
    };

    return _client.postMultipart<GlassesCreateResponse>(
      '/glasses/create/',
      fields: fields,
      files: files,
      fromJson: GlassesCreateResponse.fromMap,
    );
  }

  Future<Result<GlassPatchResponse, StirError>> patchGlass(
    String id, {
    String? name,
    String? description,
    MultipartFile? picture,
  }) {
    final fields = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    };

    final files = {if (picture != null) 'picture': picture};

    return _client.patchMultipart<GlassPatchResponse>(
      '/glasses/$id/',
      fields: fields,
      files: files,
      fromJson: GlassPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteGlass(String id) {
    return _client.delete('/glasses/$id/');
  }

  /// Ingredients

  Future<Result<IngredientsListResponse, StirError>> getIngredientsList() {
    return _client.get<IngredientsListResponse>(
    	'/ingredients/',
    	fromJson: IngredientsListResponse.fromMap,
    );
  }

  Future<Result<IngredientsListResponse, StirError>> searchIngredients({String? query}) {
    return _client.get<IngredientsListResponse>(
      '/ingredients/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: IngredientsListResponse.fromMap,
    );
  }

  Future<Result<IngredientCreateResponse, StirError>> createIngredient({
    required String name,
    required String description,
    required MultipartFile picture,
    required Map<String, dynamic> categories,
    required List<String> matches,
  }) {
    final fields = {
      'name': name,
      'description': description,
      'categories': categories,
      'matches': matches,
    };

    final files = {
      'picture': picture,
    };

    return _client.postMultipart<IngredientCreateResponse>(
      '/ingredients/create/',
      fields: fields,
      files: files,
      fromJson: IngredientCreateResponse.fromMap,
    );
  }

  Future<Result<IngredientPatchResponse, StirError>> patchIngredient(
    String id, {
    String? name,
    String? description,
    MultipartFile? picture,
    Map<String, dynamic>? categories,
    List<String>? matches,
  }) {
    final fields = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (categories != null) 'categories': categories,
      if (matches != null) 'matches': matches,
    };

    final files = {if (picture != null) 'picture': picture};

    return _client.patchMultipart<IngredientPatchResponse>(
      '/ingredients/$id/',
      fields: fields,
      files: files,
      fromJson: IngredientPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteIngredient(String id) {
    return _client.delete('/ingredients/$id/');
  }

  /// Recipes

  Future<Result<RecipesListResponse, StirError>> getRecipesList() {
    return _client.get<RecipesListResponse>(
      '/recipes/',
      fromJson: RecipesListResponse.fromMap,
    );
  }

  Future<Result<RecipesListResponse, StirError>> searchRecipes({String? query}) {
    return _client.get<RecipesListResponse>(
      '/recipes/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: RecipesListResponse.fromMap,
    );
  }

  Future<Result<RecipeCreateResponse, StirError>> createRecipe(Map<String, dynamic> body) {
    return _client.post<RecipeCreateResponse>(
      '/recipes/create/',
      body: body,
      fromJson: RecipeCreateResponse.fromMap,
    );
  }

  Future<Result<RecipePatchResponse, StirError>> patchRecipe(String id, Map<String, dynamic> body) {
    return _client.patch<RecipePatchResponse>(
      '/recipes/$id/',
      body: body,
      fromJson: RecipePatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteRecipe(String id) {
    return _client.delete('/recipes/$id/');
  }

  /// Drinks

  Future<Result<DrinksListResponse, StirError>> getDrinksList() {
    return _client.get<DrinksListResponse>(
      '/drinks/',
      fromJson: DrinksListResponse.fromMap,
    );
  }

  Future<Result<DrinksListResponse, StirError>> searchDrinks({String? query}) {
    return _client.get<DrinksListResponse>(
      '/drinks/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: DrinksListResponse.fromMap,
    );
  }

  Future<Result<DrinkCreateResponse, StirError>> createDrink({
    required String name,
    required String description,
    required MultipartFile picture,
    required Map<String, dynamic> categories,
    required String recipe,
    required String author,
    required String glass,
  }) {
    final fields = {
      'name': name,
      'description': description,
      'categories': categories,
      'recipe': recipe,
      'author': author,
      'glass': glass,
    };

    final files = {
      'picture': picture,
    };

    return _client.postMultipart<DrinkCreateResponse>(
      '/drinks/create/',
      fields: fields,
      files: files,
      fromJson: DrinkCreateResponse.fromMap,
    );
  }

  Future<Result<Drink, StirError>> retrieveDrink(String id) {
    return _client.get<Drink>(
      '/drinks/$id/',
      fromJson: Drink.fromJson,
    );
  }

  Future<Result<DrinkPatchResponse, StirError>> patchDrink(
    String id, {
    String? name,
    String? description,
    MultipartFile? picture,
    Map<String, dynamic>? categories,
    String? recipe,
    String? author,
    String? glass,
  }) {
    final fields = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (categories != null) 'categories': categories,
      if (recipe != null) 'recipe': recipe,
      if (author != null) 'author': author,
      if (glass != null) 'glass': glass,
    };

    final files = {if (picture != null) 'picture': picture};

    return _client.patchMultipart<DrinkPatchResponse>(
      '/drinks/$id/',
      fields: fields,
      files: files,
      fromJson: DrinkPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteDrink(String id) {
    return _client.delete('/drinks/$id/');
  }

  /// Ratings

  Future<Result<RatingCreateResponse, StirError>> createRating(Map<String, dynamic> body) {
    return _client.post<RatingCreateResponse>(
      '/ratings/create/',
      body: body,
      fromJson: RatingCreateResponse.fromMap,
    );
  }

  Future<Result<RatingPatchResponse, StirError>> patchRating(String id, Map<String, dynamic> body) {
    return _client.patch<RatingPatchResponse>(
      '/ratings/$id/',
      body: body,
      fromJson: RatingPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteRating(String id) {
    return _client.delete('/ratings/$id/');
  }

  /// Favorites

  Future<Result<dynamic, StirError>> favoriteAction(Map<String, dynamic> body) {
    return _client.post(
      '/self/favorites/',
      body: body,
    );
  }
}
