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
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

abstract class ApiRepository {

  Future<DataState<AllChoicesResponse>> getAllChoices();

  Future<DataState<SignupResponse>> signup({
    required SignupRequest request,
  });

  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request,
  });

  Future<DataState<void>> verifyToken({
    required String accessToken,
  });

  Future<DataState<LoginResponse>> refreshToken({
    required String refreshToken,
  });

  Future<DataState<void>> checkUsernameValidity({
    required String username,
  });

  /// Profiles
  Future<DataState<ProfileListResponse>> getProfileList({
    required ProfileListRequest request,
  });

  Future<DataState<Profile>> getSelfProfile();

  Future<DataState<ProfileListResponse>> searchProfiles({
    required ProfilesSearchRequest request,
  });

  Future<DataState<ProfileCreateResponse>> createProfile({
    required ProfileCreateRequest request,
  });

  Future<DataState<ProfilePatchResponse>> patchProfile({
    required ProfilePatchRequest request,
  });

  /// Glasses
  Future<DataState<GlassesListResponse>> getGlassesList({
    required GlassesListRequest request,
  });

  Future<DataState<GlassesListResponse>> searchGlasses({
    required GlassesSearchRequest request,
  });

  Future<DataState<GlassesCreateResponse>> createGlass({
    required GlassesCreateRequest request,
  });

  Future<DataState<GlassPatchResponse>> patchGlass({
    required GlassPatchRequest request,
  });

  Future<void> deleteGlass({
    required GlassDeleteRequest request,
  });

  /// Ingredients
  Future<DataState<IngredientsListResponse>> getIngredientsList({
    required IngredientsListRequest request,
  });

  Future<DataState<IngredientCreateResponse>> createIngredient({
    required IngredientCreateRequest request,
  });

  Future<DataState<IngredientPatchResponse>> patchIngredient({
    required IngredientPatchRequest request,
  });

  Future<void> deleteIngredient({
    required IngredientDeleteRequest request,
  });

  Future<DataState<IngredientsListResponse>> searchIngredients({
    required IngredientsSearchRequest request,
  });

  /// Recipes
  Future<DataState<RecipesListResponse>> getRecipesList({
    required RecipesListRequest request,
  });

  Future<DataState<RecipesListResponse>> searchRecipes({
    required RecipesSearchRequest request,
  });

  Future<DataState<RecipeCreateResponse>> createRecipe({
    required RecipeCreateRequest request,
  });

  Future<DataState<RecipePatchResponse>> patchRecipe({
    required RecipePatchRequest request,
  });

  Future<void> deleteRecipe({
    required RecipeDeleteRequest request,
  });


  /// Drinks
  Future<DataState<DrinksListResponse>> getDrinksList({
    required DrinksListRequest request,
  });

  Future<DataState<DrinksListResponse>> searchDrinks({
    required DrinksSearchRequest request,
  });

  Future<DataState<DrinkCreateResponse>> createDrink({
    required DrinkCreateRequest request,
  });

  Future<DataState<Drink>> retrieveDrink({
    required DrinkRetrieveRequest request,
  });

  Future<DataState<DrinkPatchResponse>> patchDrink({
    required DrinkPatchRequest request,
  });

  Future<void> deleteDrink({
    required DrinkDeleteRequest request,
  });

  /// Ratings

  Future<DataState<RatingCreateResponse>> createRating({
    required RatingCreateRequest request,
  });

  Future<DataState<RatingPatchResponse>> patchRating({
    required RatingPatchRequest request,
  });

  Future<void> deleteRating({
    required RatingDeleteRequest request,
  });


  /// Preferences

  Future<DataState<dynamic>> favoriteAction({
    required String drinkId,
  });

}