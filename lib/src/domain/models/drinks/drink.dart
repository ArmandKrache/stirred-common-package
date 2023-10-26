import 'package:stirred_common_domain/src/domain/models/categories.dart';
import 'package:stirred_common_domain/src/domain/models/generic_data_model.dart';
import 'package:stirred_common_domain/src/domain/models/generic_preview_data_model.dart';
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
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
  });

  factory Drink.fromMap(Map<String, dynamic> map) {
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
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, description];

}