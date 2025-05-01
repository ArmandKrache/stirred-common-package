import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipe.dart';
import 'package:stirred_common_domain/src/domain/models/rating/rating.dart';
import 'package:stirred_common_domain/src/domain/models/categories/categories.dart';
import 'package:stirred_common_domain/src/domain/models/preferences/preferences.dart';

/// Test models for use in unit tests
class TestModels {
  // Profile test models
  static const minimalProfile = Profile(
    id: 'test-profile-id',
  );

  static const fullProfile = Profile(
    id: 'test-profile-id',
    email: 'test@example.com',
    name: 'Test Profile Name',
    description: 'Test Profile Description',
    picture: 'test-profile-picture.jpg',
    dateOfBirth: '1990-01-01',
    preferences: Preferences(),
  );

  // Drink test models
  static const minimalDrink = Drink(
    id: 'test-drink-id',
    name: 'Test Drink Name',
    picture: 'test-drink-picture.jpg',
  );

  static Drink get fullDrink => Drink(
        id: 'test-drink-id',
        name: 'Test Drink Name',
        picture: 'test-drink-picture.jpg',
        description: 'Test Drink Description',
        recipe: fullRecipe,
        author: fullProfile,
        glass: fullGlass,
        categories: fullCategories,
        averageRating: 4.5,
        ratings: [fullRating],
        ratingsCount: 1,
        userRating: fullRating,
      );

  // Recipe test models
  static final fullRecipe = Recipe(
    id: 'test-recipe-id',
    name: 'Test Recipe Name',
    description: 'Test Recipe Description',
    preparationTime: 10,
    difficulty: 'Easy',
    instructions: ['Step 1', 'Step 2'],
    ingredients: [],
  );

  // Glass test models
  static const fullGlass = Glass(
    id: 'test-glass-id',
    name: 'Test Glass Name',
    description: 'Test Glass Description',
    picture: 'test-glass-picture.jpg',
  );

  // Categories test models
  static const fullCategories = Categories(
    origins: ['Test Origin'],
    strengths: ['Test Strength'],
    eras: ['Test Era'],
    diets: ['Test Diet'],
    seasons: ['Test Season'],
    colors: ['Test Color'],
    keywords: ['Test Keyword'],
  );

  // Rating test models
  static Rating get fullRating => Rating(
        id: 'test-rating-id',
        username: 'Test User',
        userPicture: 'test-user-picture.jpg',
        comment: 'Test Comment',
        rating: 4,
        upvotes: 0,
        creationTime: DateTime.now(),
      );

  // JSON test data
  static const minimalProfileJson = {
    'id': 'test-profile-id',
  };

  static const fullProfileJson = {
    'id': 'test-profile-id',
    'user': {
      'email': 'test@example.com',
    },
    'name': 'Test Profile Name',
    'description': 'Test Profile Description',
    'picture': 'test-profile-picture.jpg',
    'date_of_birth': '1990-01-01',
    'preferences': <String, dynamic>{},
  };

  static const minimalDrinkJson = {
    'id': 'test-drink-id',
    'name': 'Test Drink Name',
    'picture': 'test-drink-picture.jpg',
  };

  static Map<String, dynamic> get fullDrinkJson => {
        'id': 'test-drink-id',
        'name': 'Test Drink Name',
        'picture': 'test-drink-picture.jpg',
        'description': 'Test Drink Description',
        'recipe': fullRecipe.toJson(),
        'author': fullProfile.toJson(),
        'glass': fullGlass.toJson(),
        'categories': fullCategories.toJson(),
        'average_rating': 4.5,
        'ratings': [fullRating.toJson()],
        'ratings_count': 1,
        'user_rating': fullRating.toJson(),
      };
} 