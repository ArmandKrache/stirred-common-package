import 'package:http/http.dart' show MultipartFile;
import 'package:stirred_common_domain/src/data/apis/drinks_api.dart';
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

class DrinksRepository {
  DrinksRepository({
    required this.drinksApi,
  });

  final DrinksApi drinksApi;

  /// Glasses
  Future<Result<GlassesListResponse, StirError>> getGlassesList({int offset = 0}) {
    return drinksApi.getGlassesList();
  }

  Future<Result<GlassesListResponse, StirError>> searchGlasses({String? query}) {
    return drinksApi.searchGlasses(query: query);
  }

  Future<Result<GlassesCreateResponse, StirError>> createGlass({
    required GlassesCreateRequest request,
  }) {
    return drinksApi.createGlass(request: request);
  }

  Future<Result<GlassPatchResponse, StirError>> patchGlass(
    String id,
    GlassPatchRequest request,
  ) {
    return drinksApi.patchGlass(
      id,
      request,
    );
  }

  Future<Result<void, StirError>> deleteGlass(String id) {
    return drinksApi.deleteGlass(id);
  }

  /// Ingredients

  Future<Result<IngredientsListResponse, StirError>> getIngredientsList() {
    return drinksApi.getIngredientsList();
  }

  Future<Result<IngredientsListResponse, StirError>> searchIngredients({String? query}) {
    return drinksApi.searchIngredients(query: query);
  }

  Future<Result<IngredientCreateResponse, StirError>> createIngredient({
    required String name,
    required String description,
    required MultipartFile picture,
    required Map<String, dynamic> categories,
    required List<String> matches,
  }) {
    return drinksApi.createIngredient(
      name: name,
      description: description,
      picture: picture,
      categories: categories,
      matches: matches,
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
    return drinksApi.patchIngredient(
      id,
      name: name,
      description: description,
      picture: picture,
      categories: categories,
      matches: matches,
    );
  }

  Future<Result<void, StirError>> deleteIngredient(String id) {
    return drinksApi.deleteIngredient(id);
  }

  /// Recipes

  Future<Result<RecipesListResponse, StirError>> getRecipesList() {
    return drinksApi.getRecipesList();
  }

  Future<Result<RecipesListResponse, StirError>> searchRecipes({String? query}) {
    return drinksApi.searchRecipes(query: query);
  }

  Future<Result<RecipeCreateResponse, StirError>> createRecipe(RecipeCreateRequest request) {
    return drinksApi.createRecipe(request);
  }

  Future<Result<RecipePatchResponse, StirError>> patchRecipe(String id, Map<String, dynamic> body) {
    return drinksApi.patchRecipe(id, body);
  }

  Future<Result<void, StirError>> deleteRecipe(String id) {
    return drinksApi.deleteRecipe(id);
  }

  /// Drinks

  Future<Result<DrinksListResponse, StirError>> getDrinksList({int offset = 0}) {
    return drinksApi.getDrinksList();
  }

  Future<Result<DrinksListResponse, StirError>> searchDrinks({String? query}) {
    return drinksApi.searchDrinks(query: query);
  }

  Future<Result<DrinkCreateResponse, StirError>> createDrink({
    required DrinkCreateRequest request,
  }) {
    return drinksApi.createDrink(request: request);
  }

  Future<Result<Drink, StirError>> retrieveDrink(String id) {
    return drinksApi.retrieveDrink(id);
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
    return drinksApi.patchDrink(
      id,
      name: name,
      description: description,
      picture: picture,
      categories: categories,
      recipe: recipe,
      author: author,
      glass: glass,
    );
  }

  Future<Result<void, StirError>> deleteDrink(String id) {
    return drinksApi.deleteDrink(id);
  }

  /// Ratings

  Future<Result<RatingCreateResponse, StirError>> createRating(Map<String, dynamic> body) {
    return drinksApi.createRating(body);
  }

  Future<Result<RatingPatchResponse, StirError>> patchRating(String id, Map<String, dynamic> body) {
    return drinksApi.patchRating(id, body);
  }

  Future<Result<void, StirError>> deleteRating(String id) {
    return drinksApi.deleteRating(id);
  }

  /// Favorites

  Future<Result<dynamic, StirError>> favoriteAction(Map<String, dynamic> body) {
    return drinksApi.favoriteAction(body);
  }

  /// All Choices

  Future<Result<AllChoicesResponse, StirError>> getAllChoices() {
    return drinksApi.getAllChoices();
  }
}
