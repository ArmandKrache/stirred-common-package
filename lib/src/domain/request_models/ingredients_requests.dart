import 'package:http/http.dart' show MultipartFile;

class IngredientsListRequest {
  IngredientsListRequest();
}

class IngredientCreateRequest {
  final String name;
  final String description;
  final MultipartFile picture;
  final List<String>? matches;
  final Map<String, List<String>> categories;

  IngredientCreateRequest({
    required this.name,
    required this.description,
    required this.picture,
    required this.categories,
    this.matches,
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