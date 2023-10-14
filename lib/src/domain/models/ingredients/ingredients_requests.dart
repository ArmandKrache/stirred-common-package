import 'package:dio/dio.dart';

class IngredientsListRequest {
  IngredientsListRequest();
}

class IngredientCreateRequest {
  final String? name;
  final String? description;
  final MultipartFile? picture;
  final List<String>? matches;
  final Map<String, List<String>>? categories;

  IngredientCreateRequest({
    this.name,
    this.description,
    this.picture,
    this.matches,
    this.categories,
  });
}

class IngredientDeleteRequest {
  final String id;

  IngredientDeleteRequest({required this.id});
}

class IngredientsSearchRequest {
  final String query;

  IngredientsSearchRequest({this.query = ""});
}

class IngredientPatchRequest {
  final String id;
  final Map<String, dynamic> body;

  IngredientPatchRequest({required this.id, required this.body});
}