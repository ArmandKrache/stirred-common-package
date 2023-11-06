import 'package:stirred_common_domain/src/data/datasources/base/base_api_repository.dart';
import 'package:stirred_common_domain/src/data/datasources/admin_api_service.dart';
import 'package:stirred_common_domain/src/data/datasources/stirred_api_service.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink_patch_response.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drinks_requests.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile_create_response.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile_patch_response.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile_requests.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glasses_requests.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredients_requests.dart';
import 'package:stirred_common_domain/src/domain/models/login_request.dart';
import 'package:stirred_common_domain/src/domain/models/rating/rating_create_response.dart';
import 'package:stirred_common_domain/src/domain/models/rating/rating_patch_response.dart';
import 'package:stirred_common_domain/src/domain/models/rating/ratings_requests.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipes_requests.dart';
import 'package:stirred_common_domain/src/domain/models/all_choices_response.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink_create_response.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drinks_list_response.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glass_patch_response.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glasses_create_response.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glasses_list_response.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredients_create_response.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredients_list_response.dart';
import 'package:stirred_common_domain/src/domain/models/ingredients/ingredients_patch_response.dart';
import 'package:stirred_common_domain/src/domain/models/login_response.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile_list_response.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipe_create_response.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipe_patch_response.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipes_list_response.dart';
import 'package:stirred_common_domain/src/domain/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final AdminApiService _adminApiService;
  final StirredApiService _stirredApiService;

  ApiRepositoryImpl(this._adminApiService, this._stirredApiService);

  @override
  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request
  }) {
    return getState0f<LoginResponse>(request: () => _adminApiService.getTokens(
        {"username" : request.username!, "password" : request.password!}),
    );
  }

  @override
  Future<DataState<void>> verifyToken({
    required String accessToken
  }) {
    return getState0f<void>(request: () => _adminApiService.verifyToken(
        {"token" : accessToken}),
    );
  }

  @override
  Future<DataState<LoginResponse>> refreshToken({
    required String refreshToken
  }) {
    return getState0f<LoginResponse>(request: () => _adminApiService.refreshToken(
        {"refresh" : refreshToken}),
    );
  }

  @override
  Future<DataState<AllChoicesResponse>> getAllChoices() {
    return getState0f<AllChoicesResponse>(request: () => _stirredApiService.getAllChoices());
  }

  /// Profiles
  @override
  Future<DataState<ProfileListResponse>> getProfileList({
    required ProfileListRequest request
  }) {
    return getState0f<ProfileListResponse>(request: () => _stirredApiService.getProfileList(),
    );
  }

  @override
  Future<DataState<Profile>> getSelfProfile() {
    return getState0f<Profile>(request: () => _stirredApiService.getSelfProfile(),
    );
  }

  @override
  Future<DataState<ProfileListResponse>> searchProfiles({
    required ProfilesSearchRequest request
  }) {
    return getState0f<ProfileListResponse>(request: () => _stirredApiService.searchProfiles(query: request.query),
    );
  }

  @override
  Future<DataState<ProfileCreateResponse>> createProfile({
    required ProfileCreateRequest request
  }) {
    return getState0f<ProfileCreateResponse>(request: () => _stirredApiService.createProfile(
        name: request.name,
        description: request.description,
        picture: request.picture,
        date_of_birth: request.birthdate,
    ));
  }

  @override
  Future<DataState<ProfilePatchResponse>> patchProfile({
    required ProfilePatchRequest request
  }) {
    return getState0f<ProfilePatchResponse>(request: () => _stirredApiService.patchProfile(
        request.id,
        name: request.name,
        description: request.description,
        picture: request.picture,
        date_of_birth: request.birthdate,
    ));
  }

  /// Glasses
  @override
  Future<DataState<GlassesListResponse>> getGlassesList({
    required GlassesListRequest request
  }) {
    return getState0f<GlassesListResponse>(request: () => _stirredApiService.getGlassesList(),
    );
  }

  @override
  Future<DataState<GlassesListResponse>> searchGlasses({
    required GlassesSearchRequest request
  }) {
    return getState0f<GlassesListResponse>(request: () => _stirredApiService.searchGlasses(query: request.query),
    );
  }

  @override
  Future<DataState<GlassesCreateResponse>> createGlass({
    required GlassesCreateRequest request
  }) {
    return getState0f<GlassesCreateResponse>(request: () => _stirredApiService.createGlass(
      request.name!,
        request.description!,
        request.picture!),
    );
  }

  @override
  Future<void> deleteGlass({
    required GlassDeleteRequest request
  }) {
    return _stirredApiService.deleteGlass(
        request.id!
    );
  }

  @override
  Future<DataState<GlassPatchResponse>> patchGlass({
    required GlassPatchRequest request
  }) {
    return getState0f<GlassPatchResponse>(request: () {
      return _stirredApiService.patchGlass(request.id,
        name: request.body["name"],
        description: request.body["description"],
        picture: request.body["picture"],
      );
    });
  }

  /// Ingredients
  @override
  Future<DataState<IngredientsListResponse>> getIngredientsList({
    required IngredientsListRequest request
  }) {
    return getState0f<IngredientsListResponse>(request: () => _stirredApiService.getIngredientsList(),
    );
  }

  @override
  Future<DataState<IngredientsListResponse>> searchIngredients({
    required IngredientsSearchRequest request
  }) {
    return getState0f<IngredientsListResponse>(request: () => _stirredApiService.searchIngredients(query: request.query),
    );
  }

  @override
  Future<DataState<IngredientCreateResponse>> createIngredient({
    required IngredientCreateRequest request
  }) {
    return getState0f<IngredientCreateResponse>(request: () => _stirredApiService.createIngredient(
      request.name!,
      request.description!,
      request.picture!,
      request.categories!,
      request.matches!,
    ),
    );
  }

  @override
  Future<void> deleteIngredient({
    required IngredientDeleteRequest request
  }) {
    return _stirredApiService.deleteIngredient(
        request.id
    );
  }

  @override
  Future<DataState<IngredientPatchResponse>> patchIngredient({
    required IngredientPatchRequest request
  }) {
    return getState0f<IngredientPatchResponse>(request: () {
      return _stirredApiService.patchIngredient(request.id,
        name: request.body["name"],
        description: request.body["description"],
        picture: request.body["picture"],
        categories: request.body["categories"],
        matches: request.body["matches"],
      );
    });
  }

  /// Recipes
  @override
  Future<DataState<RecipesListResponse>> getRecipesList({
    required RecipesListRequest request
  }) {
    return getState0f<RecipesListResponse>(request: () => _stirredApiService.getRecipesList(),
    );
  }

  @override
  Future<DataState<RecipesListResponse>> searchRecipes({
    required RecipesSearchRequest request
  }) {
    return getState0f<RecipesListResponse>(request: () => _stirredApiService.searchRecipes(query: request.query),
    );
  }

  @override
  Future<DataState<RecipeCreateResponse>> createRecipe({
    required RecipeCreateRequest request
  }) {
    return getState0f<RecipeCreateResponse>(request: () => _stirredApiService.createRecipe(request.toJson()));
  }

  @override
  Future<DataState<RecipePatchResponse>> patchRecipe({
    required RecipePatchRequest request
  }) {
    return getState0f<RecipePatchResponse>(request: () => _stirredApiService.patchRecipe(request.id, request.body));
  }

  @override
  Future<void> deleteRecipe({
    required RecipeDeleteRequest request
  }) {
    return _stirredApiService.deleteRecipe(
        request.id
    );
  }

  /// Drinks
  @override
  Future<DataState<DrinksListResponse>> getDrinksList({
    required DrinksListRequest request
  }) {
    return getState0f<DrinksListResponse>(request: () => _stirredApiService.getDrinksList(),
    );
  }

  @override
  Future<DataState<DrinksListResponse>> searchDrinks({
    required DrinksSearchRequest request
  }) {
    return getState0f<DrinksListResponse>(request: () => _stirredApiService.searchDrinks(query: request.query),
    );
  }

  @override
  Future<DataState<DrinkCreateResponse>> createDrink({
    required DrinkCreateRequest request
  }) {
    return getState0f<DrinkCreateResponse>(request: () => _stirredApiService.createDrink(
      name: request.name,
      description: request.description,
      picture: request.picture,
      recipe: request.recipe,
      author: request.author,
      glass: request.glass,
      categories: request.categories
    ));
  }

  @override
  Future<DataState<Drink>> retrieveDrink({
    required DrinkRetrieveRequest request
  }) {
    return getState0f<Drink>(request: () => _stirredApiService.retrieveDrink(
        request.id
    ));
  }

  @override
  Future<DataState<DrinkPatchResponse>> patchDrink({
    required DrinkPatchRequest request
  }) {
    return getState0f<DrinkPatchResponse>(request: () => _stirredApiService.patchDrink(
        request.id,
        name: request.name,
        description: request.description,
        picture: request.picture,
        recipe: request.recipe,
        author: request.author,
        glass: request.glass,
        categories: request.categories
    ));
  }

  @override
  Future<void> deleteDrink({
    required DrinkDeleteRequest request
  }) {
    return _stirredApiService.deleteDrink(
        request.id
    );
  }


  /// Ratings

  @override
  Future<DataState<RatingCreateResponse>> createRating({
    required RatingCreateRequest request
  }) {
    return getState0f<RatingCreateResponse>(request: () => _stirredApiService.createRating(request.toJson()));
  }

  @override
  Future<DataState<RatingPatchResponse>> patchRating({
    required RatingPatchRequest request
  }) {
    return getState0f<RatingPatchResponse>(request: () => _stirredApiService.patchRating(request.id, request.body));
  }

  @override
  Future<void> deleteRating({
    required RatingDeleteRequest request
  }) {
    return _stirredApiService.deleteRating(
        request.id
    );
  }

  /// Preferences

  @override
  Future<DataState<dynamic>> favoriteAction({
    required String drinkId
  }) {
    return getState0f<dynamic>(request: () => _stirredApiService.favoriteAction({"drink_id": drinkId}));
  }

}