import 'package:dio/dio.dart';

class ProfileListRequest {
  ProfileListRequest();
}

class ProfilesSearchRequest {
  final String query;
  ProfilesSearchRequest({this.query = ""});
}

class ProfileCreateRequest {
  final String name;
  final String description;
  final String email;
  final String birthdate;
  final MultipartFile picture;

  ProfileCreateRequest({
    required this.name,
    required this.description,
    required this.email,
    required this.birthdate,
    required this.picture,
  });
}

class ProfilePatchRequest {
  final String id;
  final String? name;
  final String? description;
  final String? email;
  final String? birthdate;
  final MultipartFile? picture;

  ProfilePatchRequest({
    required this.id,
    this.name,
    this.description,
    this.email,
    this.birthdate,
    this.picture,
  });
}