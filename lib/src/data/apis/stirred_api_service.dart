import 'package:http/http.dart' show MultipartFile;
import 'package:stirred_common_domain/src/data/http_error_client.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:stirred_common_domain/src/domain/response_models/drink_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/all_choices_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/drink_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/drinks_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/glass_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/ingredients_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/ingredients_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/ingredients_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/glasses_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/glasses_list_response.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/rating_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/rating_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/recipe_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/recipe_patch_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/recipes_list_response.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

class StirredApiService {
  final HttpErrorClient _client;

  StirredApiService(this._client);

  Future<DataState<AllChoicesResponse>> getAllChoices() {
    return _client.get<AllChoicesResponse>(
      '/all-choices/',
      fromJson: AllChoicesResponse.fromMap,
    );
  }

  Future<DataState<Profile>> getSelfProfile() {
    return _client.get<Profile>(
      '/self/',
      fromJson: Profile.fromJson,
    );
  }

  Future<DataState<ProfileListResponse>> getProfileList() {
    return _client.get<ProfileListResponse>(
      '/profiles/',
      fromJson: ProfileListResponse.fromMap,
    );
  }

  Future<DataState<ProfileListResponse>> searchProfiles({String? query}) {
    return _client.get<ProfileListResponse>(
      '/profiles/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: ProfileListResponse.fromMap,
    );
  }

  Future<DataState<ProfileCreateResponse>> createProfile({
    required String user,
    required String name,
    required String description,
    required MultipartFile picture,
    required String dateOfBirth,
  }) {
    final fields = {
      'user': user,
      'name': name,
      'description': description,
      'date_of_birth': dateOfBirth,
    };

    final files = {
      'picture': picture,
    };

    return _client.postMultipart<ProfileCreateResponse>(
      '/profiles/create/',
      fields: fields,
      files: files,
      fromJson: ProfileCreateResponse.fromMap,
    );
  }

  Future<DataState<Profile>> retrieveProfile(String id) {
    return _client.get<Profile>(
      '/profiles/$id/',
      fromJson: Profile.fromJson,
    );
  }

  Future<DataState<ProfilePatchResponse>> patchProfile(
    String id, {
    String? name,
    String? description,
    MultipartFile? picture,
    String? dateOfBirth,
  }) {
    final fields = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    };

    final files = picture != null ? {'picture': picture} : null;

    return _client.patchMultipart<ProfilePatchResponse>(
      '/profiles/$id/',
      fields: fields,
      files: files,
      fromJson: ProfilePatchResponse.fromMap,
    );
  }

  Future<DataState<GlassesListResponse>> getGlassesList() {
    return _client.get<GlassesListResponse>(
      '/glasses/',
      fromJson: GlassesListResponse.fromMap,
    );
  }

  Future<DataState<GlassesListResponse>> searchGlasses({String? query}) {
    return _client.get<GlassesListResponse>(
      '/glasses/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: GlassesListResponse.fromMap,
    );
  }

  Future<DataState<GlassesCreateResponse>> createGlass({
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

  Future<DataState<GlassPatchResponse>> patchGlass(
    String id, {
    String? name,
    String? description,
    MultipartFile? picture,
  }) {
    final fields = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    };

    final files = picture != null ? {'picture': picture} : null;

    return _client.patchMultipart<GlassPatchResponse>(
      '/glasses/$id/',
      fields: fields,
      files: files,
      fromJson: GlassPatchResponse.fromMap,
    );
  }

  Future<DataState<void>> deleteGlass(String id) {
    return _client.delete('/glasses/$id/');
  }

  Future<DataState<IngredientsListResponse>> getIngredientsList() {
    return _client.get<IngredientsListResponse>(
      '/ingredients/',
      fromJson: IngredientsListResponse.fromMap,
    );
  }

  Future<DataState<IngredientsListResponse>> searchIngredients({String? query}) {
    return _client.get<IngredientsListResponse>(
      '/ingredients/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: IngredientsListResponse.fromMap,
    );
  }

  Future<DataState<IngredientCreateResponse>> createIngredient({
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

  Future<DataState<IngredientPatchResponse>> patchIngredient(
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

    final files = picture != null ? {'picture': picture} : null;

    return _client.patchMultipart<IngredientPatchResponse>(
      '/ingredients/$id/',
      fields: fields,
      files: files,
      fromJson: IngredientPatchResponse.fromMap,
    );
  }

  Future<DataState<void>> deleteIngredient(String id) {
    return _client.delete('/ingredients/$id/');
  }

  Future<DataState<RecipesListResponse>> getRecipesList() {
    return _client.get<RecipesListResponse>(
      '/recipes/',
      fromJson: RecipesListResponse.fromMap,
    );
  }

  Future<DataState<RecipesListResponse>> searchRecipes({String? query}) {
    return _client.get<RecipesListResponse>(
      '/recipes/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: RecipesListResponse.fromMap,
    );
  }

  Future<DataState<RecipeCreateResponse>> createRecipe(Map<String, dynamic> body) {
    return _client.post<RecipeCreateResponse>(
      '/recipes/create/',
      body: body,
      fromJson: RecipeCreateResponse.fromMap,
    );
  }

  Future<DataState<RecipePatchResponse>> patchRecipe(String id, Map<String, dynamic> body) {
    return _client.patch<RecipePatchResponse>(
      '/recipes/$id/',
      body: body,
      fromJson: RecipePatchResponse.fromMap,
    );
  }

  Future<DataState<void>> deleteRecipe(String id) {
    return _client.delete('/recipes/$id/');
  }

  Future<DataState<DrinksListResponse>> getDrinksList() {
    return _client.get<DrinksListResponse>(
      '/drinks/',
      fromJson: DrinksListResponse.fromMap,
    );
  }

  Future<DataState<DrinksListResponse>> searchDrinks({String? query}) {
    return _client.get<DrinksListResponse>(
      '/drinks/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: DrinksListResponse.fromMap,
    );
  }

  Future<DataState<DrinkCreateResponse>> createDrink({
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

  Future<DataState<Drink>> retrieveDrink(String id) {
    return _client.get<Drink>(
      '/drinks/$id/',
      fromJson: Drink.fromJson,
    );
  }

  Future<DataState<DrinkPatchResponse>> patchDrink(
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

    final files = picture != null ? {'picture': picture} : null;

    return _client.patchMultipart<DrinkPatchResponse>(
      '/drinks/$id/',
      fields: fields,
      files: files,
      fromJson: DrinkPatchResponse.fromMap,
    );
  }

  Future<DataState<void>> deleteDrink(String id) {
    return _client.delete('/drinks/$id/');
  }

  Future<DataState<RatingCreateResponse>> createRating(Map<String, dynamic> body) {
    return _client.post<RatingCreateResponse>(
      '/ratings/create/',
      body: body,
      fromJson: RatingCreateResponse.fromMap,
    );
  }

  Future<DataState<RatingPatchResponse>> patchRating(String id, Map<String, dynamic> body) {
    return _client.patch<RatingPatchResponse>(
      '/ratings/$id/',
      body: body,
      fromJson: RatingPatchResponse.fromMap,
    );
  }

  Future<DataState<void>> deleteRating(String id) {
    return _client.delete('/ratings/$id/');
  }

  Future<DataState<dynamic>> favoriteAction(Map<String, dynamic> body) {
    return _client.post(
      '/self/favorites/',
      body: body,
    );
  }
}
