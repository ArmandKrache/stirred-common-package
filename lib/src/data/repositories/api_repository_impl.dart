import 'package:stirred_common_domain/src/data/apis/admin_api_service.dart';
import 'package:stirred_common_domain/src/data/apis/stirred_api_service.dart';
import 'package:stirred_common_domain/src/domain/models/auth/signup_response.dart';
import 'package:stirred_common_domain/src/domain/models/auth/signup_requests.dart';
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
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

class ApiRepositoryImpl implements ApiRepository {
  final AdminApiService _adminApiService;
  final StirredApiService _stirredApiService;

  ApiRepositoryImpl(this._adminApiService, this._stirredApiService);

  @override
  Future<DataState<SignupResponse>> signup({
    required SignupRequest request
  }) {
    return _adminApiService.signup({
      "username": request.email,
      "email": request.email,
      "password": request.password
    });
  }

  @override
  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request
  }) {
    return _adminApiService.getTokens({
      "username": request.username!,
      "password": request.password!
    });
  }

  @override
  Future<DataState<void>> verifyToken({
    required String accessToken
  }) {
    return _adminApiService.verifyToken({
      "token": accessToken
    });
  }

  @override
  Future<DataState<LoginResponse>> refreshToken({
    required String refreshToken
  }) {
    return _adminApiService.refreshToken({
      "refresh": refreshToken
    });
  }

  @override
  Future<DataState<void>> checkUsernameValidity({
    required String username
  }) {
    return _adminApiService.checkUsernameValidity({
      "username": username
    });
  }

  @override
  Future<DataState<AllChoicesResponse>> getAllChoices() {
    return _stirredApiService.getAllChoices();
  }

  /// Profiles
  @override
  Future<DataState<ProfileListResponse>> getProfileList({
    required ProfileListRequest request
  }) {
    return _stirredApiService.getProfileList();
  }

  @override
  Future<DataState<Profile>> getSelfProfile() {
    return _stirredApiService.getSelfProfile();
  }

  @override
  Future<DataState<ProfileListResponse>> searchProfiles({
    required ProfilesSearchRequest request
  }) {
    return _stirredApiService.searchProfiles(query: request.query);
  }

  @override
  Future<DataState<ProfileCreateResponse>> createProfile({
    required ProfileCreateRequest request
  }) {
    return _stirredApiService.createProfile(
      user: request.user,
      name: request.name,
      description: request.description,
      picture: request.picture,
      dateOfBirth: request.birthdate,
    );
  }

  @override
  Future<DataState<ProfilePatchResponse>> patchProfile({
    required ProfilePatchRequest request
  }) {
    return _stirredApiService.patchProfile(
      request.id,
      name: request.name,
      description: request.description,
      picture: request.picture,
      dateOfBirth: request.birthdate,
    );
  }

  /// Glasses
  @override
  Future<DataState<GlassesListResponse>> getGlassesList({
    required GlassesListRequest request
  }) {
    return _stirredApiService.getGlassesList();
  }

  @override
  Future<DataState<GlassesListResponse>> searchGlasses({
    required GlassesSearchRequest request
  }) {
    return _stirredApiService.searchGlasses(query: request.query);
  }

  @override
  Future<DataState<GlassesCreateResponse>> createGlass({
    required GlassesCreateRequest request
  }) {
    return _stirredApiService.createGlass(
      name: request.name!,
      description: request.description!,
      picture: request.picture!,
    );
  }

  @override
  Future<DataState<void>> deleteGlass({
    required GlassDeleteRequest request
  }) {
    return _stirredApiService.deleteGlass(request.id!);
  }

  @override
  Future<DataState<GlassPatchResponse>> patchGlass({
    required GlassPatchRequest request
  }) {
    return _stirredApiService.patchGlass(
      request.id,
      name: request.body["name"],
      description: request.body["description"],
      picture: request.body["picture"],
    );
  }

  /// Ingredients
  @override
  Future<DataState<IngredientsListResponse>> getIngredientsList({
    required IngredientsListRequest request
  }) {
    return _stirredApiService.getIngredientsList();
  }

  @override
  Future<DataState<IngredientsListResponse>> searchIngredients({
    required IngredientsSearchRequest request
  }) {
    return _stirredApiService.searchIngredients(query: request.query);
  }

  @override
  Future<DataState<IngredientCreateResponse>> createIngredient({
    required IngredientCreateRequest request
  }) {
    return _stirredApiService.createIngredient(
      name: request.name!,
      description: request.description!,
      picture: request.picture!,
      categories: request.categories!,
      matches: request.matches!,
    );
  }

  @override
  Future<DataState<void>> deleteIngredient({
    required IngredientDeleteRequest request
  }) {
    return _stirredApiService.deleteIngredient(request.id);
  }

  @override
  Future<DataState<IngredientPatchResponse>> patchIngredient({
    required IngredientPatchRequest request
  }) {
    return _stirredApiService.patchIngredient(
      request.id,
      name: request.body["name"],
      description: request.body["description"],
      picture: request.body["picture"],
      categories: request.body["categories"],
      matches: request.body["matches"],
    );
  }

  /// Recipes
  @override
  Future<DataState<RecipesListResponse>> getRecipesList({
    required RecipesListRequest request
  }) {
    return _stirredApiService.getRecipesList();
  }

  @override
  Future<DataState<RecipesListResponse>> searchRecipes({
    required RecipesSearchRequest request
  }) {
    return _stirredApiService.searchRecipes(query: request.query);
  }

  @override
  Future<DataState<RecipeCreateResponse>> createRecipe({
    required RecipeCreateRequest request
  }) {
    return _stirredApiService.createRecipe(request.toJson());
  }

  @override
  Future<DataState<RecipePatchResponse>> patchRecipe({
    required RecipePatchRequest request
  }) {
    return _stirredApiService.patchRecipe(request.id, request.body);
  }

  @override
  Future<DataState<void>> deleteRecipe({
    required RecipeDeleteRequest request
  }) {
    return _stirredApiService.deleteRecipe(request.id);
  }

  /// Drinks
  @override
  Future<DataState<DrinksListResponse>> getDrinksList({
    required DrinksListRequest request
  }) {
    return _stirredApiService.getDrinksList();
  }

  @override
  Future<DataState<DrinksListResponse>> searchDrinks({
    required DrinksSearchRequest request
  }) {
    return _stirredApiService.searchDrinks(query: request.query);
  }

  @override
  Future<DataState<DrinkCreateResponse>> createDrink({
    required DrinkCreateRequest request
  }) {
    return _stirredApiService.createDrink(
      name: request.name,
      description: request.description,
      picture: request.picture,
      categories: request.categories,
      recipe: request.recipe,
      author: request.author,
      glass: request.glass,
    );
  }

  @override
  Future<DataState<Drink>> retrieveDrink({
    required DrinkRetrieveRequest request
  }) {
    return _stirredApiService.retrieveDrink(request.id);
  }

  @override
  Future<DataState<DrinkPatchResponse>> patchDrink({
    required DrinkPatchRequest request
  }) {
    return _stirredApiService.patchDrink(
      request.id,
      name: request.name,
      description: request.description,
      picture: request.picture,
      categories: request.categories,
      recipe: request.recipe,
      glass: request.glass,
      author: request.author,
    );
  }

  @override
  Future<DataState<void>> deleteDrink({
    required DrinkDeleteRequest request
  }) {
    return _stirredApiService.deleteDrink(request.id);
  }

  /// Ratings
  @override
  Future<DataState<RatingCreateResponse>> createRating({
    required RatingCreateRequest request
  }) {
    return _stirredApiService.createRating(request.toJson());
  }

  @override
  Future<DataState<RatingPatchResponse>> patchRating({
    required RatingPatchRequest request
  }) {
    return _stirredApiService.patchRating(request.id, request.body);
  }

  @override
  Future<DataState<void>> deleteRating({
    required RatingDeleteRequest request
  }) {
    return _stirredApiService.deleteRating(request.id);
  }

  /// Preferences
  @override
  Future<DataState<dynamic>> favoriteAction({
    required String drinkId
  }) {
    return _stirredApiService.favoriteAction({"drink_id": drinkId});
  }
}