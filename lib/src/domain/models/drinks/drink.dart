import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/domain/models/categories.dart';
import 'package:stirred_common_domain/src/domain/models/generic_data_model.dart';
import 'package:stirred_common_domain/src/domain/models/generic_preview_data_model.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/models/rating/rating.dart';
import 'package:stirred_common_domain/src/domain/models/recipes/recipe.dart';
import 'package:equatable/equatable.dart';

class Drink extends Equatable implements GenericDataModel {
  final String id;
  final String name;
  final String description;
  final String picture;
  final Profile author;
  final Glass glass;
  final Recipe recipe;
  final Categories categories;
  final double averageRating;
  final List<Rating> ratings;
  final int ratingsCount;
  final Rating? userRating;

  const Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.author,
    required this.glass,
    required this.recipe,
    required this.categories,
    required this.averageRating,
    required this.ratings,
    required this.ratingsCount,
    required this.userRating,
  });

  factory Drink.fromMap(Map<String, dynamic> map) {
    //logger.d(map);
    return Drink(
      id: map['id'] ?? "",
      name : map['name'] ?? "",
      description: map['description'] ?? "",
      picture: map['picture'] ?? "",
      recipe: map['recipe'] != null ? Recipe.fromMap(map['recipe']) :  Recipe.empty(),
      author: map['author'] != null ? Profile.fromMap(map['author']) :  Profile.empty(),
      glass: map['glass'] != null ? Glass.fromMap(map['glass']) :  Glass.empty(),
      categories: map['categories'] != null ? Categories.fromMap(map['categories']) : Categories.empty(),
      averageRating: map['average_rating'] ?? 0.0,
      ratings: List<Rating>.from((map['ratings'] ?? []).map(
              (element) => Rating.fromMap(element))
      ),
      ratingsCount: map['ratings_count'] ?? 0,
      userRating: map['user_rating'] != null ? Rating.fromMap(map['user_rating']) : null
    );
  }

  factory Drink.empty() {
    return Drink(
      id: "",
      name : "",
      description: "",
      picture: "",
      author: Profile.empty(),
      glass: Glass.empty(),
      recipe: Recipe.empty(),
      categories: Categories.empty(),
      averageRating: 0.0,
      ratings: [],
      ratingsCount: 0,
      userRating: null
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, description];

}