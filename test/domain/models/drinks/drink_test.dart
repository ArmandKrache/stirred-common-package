import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../utils/test_models.dart';

void main() {
  group('Drink', () {
    test('should create a drink with required fields', () {
      const drink = TestModels.minimalDrink;

      expect(drink.id, 'test-drink-id');
      expect(drink.name, 'Test Drink Name');
      expect(drink.picture, 'test-drink-picture.jpg');
      expect(drink.description, null);
      expect(drink.recipe, null);
      expect(drink.author, null);
      expect(drink.glass, null);
      expect(drink.categories, null);
      expect(drink.averageRating, 0.0);
      expect(drink.ratings, []);
      expect(drink.ratingsCount, 0);
      expect(drink.userRating, null);
    });

    test('should create a drink with all fields', () {
      final drink = TestModels.fullDrink;
      final rating = TestModels.fullRating;

      expect(drink.id, 'test-drink-id');
      expect(drink.name, 'Test Drink Name');
      expect(drink.picture, 'test-drink-picture.jpg');
      expect(drink.description, 'Test Drink Description');
      expect(drink.recipe, TestModels.fullRecipe);
      expect(drink.author, TestModels.fullProfile);
      expect(drink.glass, TestModels.fullGlass);
      expect(drink.categories, TestModels.fullCategories);
      expect(drink.averageRating, 4.5);
      expect(drink.ratings.length, 1);
      expect(drink.ratings[0].id, rating.id);
      expect(drink.ratings[0].username, rating.username);
      expect(drink.ratings[0].userPicture, rating.userPicture);
      expect(drink.ratings[0].comment, rating.comment);
      expect(drink.ratings[0].rating, rating.rating);
      expect(drink.ratings[0].upvotes, rating.upvotes);
      expect(drink.ratingsCount, 1);
      expect(drink.userRating?.id, rating.id);
      expect(drink.userRating?.username, rating.username);
      expect(drink.userRating?.userPicture, rating.userPicture);
      expect(drink.userRating?.comment, rating.comment);
      expect(drink.userRating?.rating, rating.rating);
      expect(drink.userRating?.upvotes, rating.upvotes);
    });

    test('should serialize to JSON', () {
      final drink = TestModels.fullDrink;
      final json = drink.toJson();
      
      expect(json['id'], 'test-drink-id');
      expect(json['name'], 'Test Drink Name');
      expect(json['picture'], 'test-drink-picture.jpg');
      expect(json['description'], 'Test Drink Description');
      expect(json['average_rating'], 4.5);
      expect(json['ratings_count'], 1);
    });

    test('should deserialize from JSON', () {
      final json = {
        'id': 'test-drink-id',
        'name': 'Test Drink Name',
        'picture': 'test-drink-picture.jpg',
        'description': 'Test Drink Description',
        'recipe': TestModels.fullRecipe.toJson(),
        'author': {
          'id': 'test-profile-id',
          'user': {
            'email': 'test@example.com',
            'name': 'Test User',
            'picture': 'test-user-picture.jpg',
          },
          'name': 'Test Profile Name',
          'description': 'Test Profile Description',
          'picture': 'test-profile-picture.jpg',
          'date_of_birth': '1990-01-01',
          'preferences': {
            'favorites': [],
            'likes': [],
            'dislikes': [],
            'allergies': [],
            'diets': [],
          },
        },
        'glass': TestModels.fullGlass.toJson(),
        'categories': TestModels.fullCategories.toJson(),
        'average_rating': 4.5,
        'ratings': [{
          'id': 'test-rating-id',
          'user': {
            'name': 'Test User',
            'picture': 'test-user-picture.jpg',
          },
          'comment': 'Test Comment',
          'rating': 4,
          'upvotes': 0,
          'creation_date': '2024-04-15T23:20:10.384Z',
        }],
        'ratings_count': 1,
        'user_rating': {
          'id': 'test-rating-id',
          'user': {
            'name': 'Test User',
            'picture': 'test-user-picture.jpg',
          },
          'comment': 'Test Comment',
          'rating': 4,
          'upvotes': 0,
          'creation_date': '2024-04-15T23:20:10.384Z',
        },
      };

      final drink = Drink.fromJson(json);
      
      expect(drink.id, 'test-drink-id');
      expect(drink.name, 'Test Drink Name');
      expect(drink.picture, 'test-drink-picture.jpg');
      expect(drink.description, 'Test Drink Description');
      expect(drink.averageRating, 4.5);
      expect(drink.ratingsCount, 1);
      expect(drink.ratings.length, 1);
      expect(drink.ratings[0].id, 'test-rating-id');
      expect(drink.ratings[0].username, 'Test User');
      expect(drink.ratings[0].userPicture, 'test-user-picture.jpg');
      expect(drink.ratings[0].comment, 'Test Comment');
      expect(drink.ratings[0].rating, 4);
      expect(drink.ratings[0].upvotes, 0);
      expect(drink.userRating?.id, 'test-rating-id');
      expect(drink.userRating?.username, 'Test User');
      expect(drink.userRating?.userPicture, 'test-user-picture.jpg');
      expect(drink.userRating?.comment, 'Test Comment');
      expect(drink.userRating?.rating, 4);
      expect(drink.userRating?.upvotes, 0);
    });

    test('should handle missing optional fields in JSON', () {
      final json = TestModels.minimalDrinkJson;
      final drink = Drink.fromJson(json);
      
      expect(drink.id, 'test-drink-id');
      expect(drink.name, 'Test Drink Name');
      expect(drink.picture, 'test-drink-picture.jpg');
      expect(drink.description, null);
      expect(drink.recipe, null);
      expect(drink.author, null);
      expect(drink.glass, null);
      expect(drink.categories, null);
      expect(drink.averageRating, 0.0);
      expect(drink.ratings, []);
      expect(drink.ratingsCount, 0);
      expect(drink.userRating, null);
    });
  });
}
