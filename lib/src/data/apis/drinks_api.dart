import 'package:http/http.dart' show MultipartFile;
import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/data/http/error_handling_client.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:stirred_common_domain/src/domain/request_models/drinks_requests.dart';
import 'package:stirred_common_domain/src/domain/request_models/glasses_requests.dart';
import 'package:stirred_common_domain/src/domain/request_models/recipes_requests.dart';
import 'package:stirred_common_domain/src/domain/response_models/all_choices_response.dart';
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
  final String urlPrefix;

  DrinksApi(this._client, {this.urlPrefix = ''});

  /// Glasses
  Future<Result<GlassesListResponse, StirError>> getGlassesList() {
    return _client.get<GlassesListResponse>(
      '$urlPrefix/glasses/',
      fromJson: GlassesListResponse.fromMap,
    );
  }

  Future<Result<GlassesListResponse, StirError>> searchGlasses({String? query}) {
    return _client.get<GlassesListResponse>(
      '$urlPrefix/glasses/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: GlassesListResponse.fromMap,
    );
  }

  Future<Result<GlassesCreateResponse, StirError>> createGlass({
    required GlassesCreateRequest request,
  }) {
    final fields = {
      'name': request.name,
      'description': request.description,
    };

    final files = {
      'picture': request.picture,
    };

    return _client.postMultipart<GlassesCreateResponse>(
      '$urlPrefix/glasses/create/',
      fields: fields,
      files: files,
      fromJson: GlassesCreateResponse.fromMap,
    );
  }

  Future<Result<GlassPatchResponse, StirError>> patchGlass(
    String id,
    GlassPatchRequest request,
  ) {
    final fields = {
      if (request.name != null) 'name': request.name,
      if (request.description != null) 'description': request.description,
    };

    final files = {if (request.picture != null) 'picture': request.picture!};

    return _client.patchMultipart<GlassPatchResponse>(
      '$urlPrefix/glasses/$id/',
      fields: fields,
      files: files,
      fromJson: GlassPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteGlass(String id) {
    return _client.delete('$urlPrefix/glasses/$id/');
  }

  /// Ingredients

  Future<Result<IngredientsListResponse, StirError>> getIngredientsList() {
    return _client.get<IngredientsListResponse>(
      '$urlPrefix/ingredients/',
      fromJson: IngredientsListResponse.fromMap,
    );
  }

  Future<Result<IngredientsListResponse, StirError>> searchIngredients({String? query}) {
    return _client.get<IngredientsListResponse>(
      '$urlPrefix/ingredients/search/',
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
      '$urlPrefix/ingredients/create/',
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
      '$urlPrefix/ingredients/$id/',
      fields: fields,
      files: files,
      fromJson: IngredientPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteIngredient(String id) {
    return _client.delete('$urlPrefix/ingredients/$id/');
  }

  /// Recipes

  Future<Result<RecipesListResponse, StirError>> getRecipesList() {
    return _client.get<RecipesListResponse>(
      '$urlPrefix/recipes/',
      fromJson: RecipesListResponse.fromMap,
    );
  }

  Future<Result<RecipesListResponse, StirError>> searchRecipes({String? query}) {
    return _client.get<RecipesListResponse>(
      '$urlPrefix/recipes/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: RecipesListResponse.fromMap,
    );
  }

  Future<Result<RecipeCreateResponse, StirError>> createRecipe(RecipeCreateRequest request) {
    return _client.post<RecipeCreateResponse>(
      '$urlPrefix/recipes/create/',
      body: request.toJson(),
      fromJson: RecipeCreateResponse.fromMap,
    );
  }

  Future<Result<RecipePatchResponse, StirError>> patchRecipe(String id, Map<String, dynamic> body) {
    return _client.patch<RecipePatchResponse>(
      '$urlPrefix/recipes/$id/',
      body: body,
      fromJson: RecipePatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteRecipe(String id) {
    return _client.delete('$urlPrefix/recipes/$id/');
  }

  /// Drinks

  Future<Result<DrinksListResponse, StirError>> getDrinksList() {
    return _client.get<DrinksListResponse>(
      '$urlPrefix/drinks/',
      fromJson: DrinksListResponse.fromMap,
    );
  }

  Future<Result<DrinksListResponse, StirError>> searchDrinks({String? query}) {
    return _client.get<DrinksListResponse>(
      '$urlPrefix/drinks/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: DrinksListResponse.fromMap,
    );
  }

  Future<Result<DrinkCreateResponse, StirError>> createDrink({
    required DrinkCreateRequest request,
  }) {
    final fields = {
      'name': request.name,
      'description': request.description,
      'categories': request.categories,
      'recipe': request.recipe,
      'author': request.author,
      'glass': request.glass,
    };

    final files = {
      'picture': request.picture,
    };

    return _client.postMultipart<DrinkCreateResponse>(
      '$urlPrefix/drinks/create/',
      fields: fields,
      files: files,
      fromJson: DrinkCreateResponse.fromMap,
    );
  }

  Future<Result<Drink, StirError>> retrieveDrink(String id) {
    return _client.get<Drink>(
      '$urlPrefix/drinks/$id/',
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
      '$urlPrefix/drinks/$id/',
      fields: fields,
      files: files,
      fromJson: DrinkPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteDrink(String id) {
    return _client.delete('$urlPrefix/drinks/$id/');
  }

  /// Ratings

  Future<Result<RatingCreateResponse, StirError>> createRating(Map<String, dynamic> body) {
    return _client.post<RatingCreateResponse>(
      '$urlPrefix/ratings/create/',
      body: body,
      fromJson: RatingCreateResponse.fromMap,
    );
  }

  Future<Result<RatingPatchResponse, StirError>> patchRating(String id, Map<String, dynamic> body) {
    return _client.patch<RatingPatchResponse>(
      '$urlPrefix/ratings/$id/',
      body: body,
      fromJson: RatingPatchResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> deleteRating(String id) {
    return _client.delete('$urlPrefix/ratings/$id/');
  }

  /// Favorites

  Future<Result<dynamic, StirError>> favoriteAction(Map<String, dynamic> body) {
    return _client.post(
      '$urlPrefix/self/favorites/',
      body: body,
    );
  }

  /// All Choices

  Future<Result<AllChoicesResponse, StirError>> getAllChoices() {
    return _client.get<AllChoicesResponse>(
      '$urlPrefix/all-choices/',
      fromJson: AllChoicesResponse.fromMap,
    );
  }
}