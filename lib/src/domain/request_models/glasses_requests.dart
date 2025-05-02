import 'package:http/http.dart' show MultipartFile;

class GlassesListRequest {
  GlassesListRequest();
}

class GlassesCreateRequest {
  final String name;
  final String description;
  final MultipartFile picture;

  GlassesCreateRequest({
    required this.name,
    required this.description,
    required this.picture,
  });
}

class GlassPatchRequest {
  final String id;
  final String? name;
  final String? description;
  final MultipartFile? picture;

  GlassPatchRequest({
    required this.id,
    this.name,
    this.description,
    this.picture,
  });
}

class GlassesSearchRequest {
  final String query;

  GlassesSearchRequest({this.query = ""});
}

class GlassDeleteRequest {
  final String? id;

  GlassDeleteRequest({this.id});
}