import 'package:equatable/equatable.dart';
import 'package:stirred_common_domain/src/domain/models/generic_preview_data_model.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

class Preferences extends Equatable {
  final List<GenericPreviewDataModel> favorites;
  final List<GenericPreviewDataModel> likes;
  final List<GenericPreviewDataModel> dislikes;
  final List<GenericPreviewDataModel> allergies;
  final List<String> diets;

  const Preferences({
    required this.favorites,
    required this.likes,
    required this.dislikes,
    required this.allergies,
    required this.diets,
  });

  factory Preferences.fromMap(Map<String, dynamic> map) {
    //logger.d(map);
    return Preferences(
      favorites: List<GenericPreviewDataModel>.from((map['favorites'] ?? []).map(
              (element) => GenericPreviewDataModel.fromMap(element))
      ),
      likes: List<GenericPreviewDataModel>.from((map['likes'] ?? []).map(
              (element) => GenericPreviewDataModel.fromMap(element))
      ),
      dislikes: List<GenericPreviewDataModel>.from((map['dislikes'] ?? []).map(
              (element) => GenericPreviewDataModel.fromMap(element))
      ),
      allergies: List<GenericPreviewDataModel>.from((map['allergies'] ?? []).map(
              (element) => GenericPreviewDataModel.fromMap(element))
      ),
      diets: List<String>.from((map['diets'] ?? []).map(
              (element) => element
      ))
    );
  }

  factory Preferences.empty() => const Preferences(
      favorites: [],
      likes : [],
      dislikes: [],
      allergies: [],
      diets: [],
    );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [favorites, likes, dislikes, allergies, diets];

}