import 'package:http/http.dart' show MultipartFile;

class ProfileListRequest {
  ProfileListRequest();
}

class ProfilesSearchRequest {
  final String query;
  ProfilesSearchRequest({this.query = ""});
}

class ProfileCreateRequest {
  final String user;
  final String name;
  final String description;
  final String birthdate;
  final MultipartFile picture;

  ProfileCreateRequest({
    required this.user,
    required this.name,
    required this.description,
    required this.birthdate,
    required this.picture,
  });
}

class ProfilePatchRequest {
  final String id;
  final String? name;
  final String? description;
  final String? birthdate;
  final MultipartFile? picture;

  ProfilePatchRequest({
    required this.id,
    this.name,
    this.description,
    this.birthdate,
    this.picture,
  });
}