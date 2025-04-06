import 'package:http/http.dart' show MultipartFile;
import 'package:stirred_common_domain/src/data/http/error_handling_client.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_patch_response.dart';
import 'package:stirred_common_domain/src/utils/resources/result.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';

class ProfileApi {
  final ErrorHandlingClient _client;

  ProfileApi(this._client);

  Future<Result<Profile, StirError>> getSelfProfile() {
    return _client.get<Profile>(
      '/self/',
      fromJson: Profile.fromJson,
    );
  }

  Future<Result<ProfileListResponse, StirError>> getProfileList() {
    return _client.get<ProfileListResponse>(
      '/profiles/',
      fromJson: ProfileListResponse.fromMap,
    );
  }

  Future<Result<ProfileListResponse, StirError>> searchProfiles({String? query}) {
    return _client.get<ProfileListResponse>(
      '/profiles/search/',
      queryParameters: query != null ? {'query': query} : null,
      fromJson: ProfileListResponse.fromMap,
    );
  }

  Future<Result<ProfileCreateResponse, StirError>> createProfile({
    required String user,
    required String name,
    required String description,
    required MultipartFile picture,
    required String dateOfBirth,
  }) {
    final fields = {
      'user': user,
      'name': name,
      'description': description,
      'date_of_birth': dateOfBirth,
    };

    final files = {
      'picture': picture,
    };

    return _client.postMultipart<ProfileCreateResponse>(
      '/profiles/create/',
      fields: fields,
      files: files,
      fromJson: ProfileCreateResponse.fromMap,
    );
  }

  Future<Result<Profile, StirError>> retrieveProfile(String id) {
    return _client.get<Profile>(
      '/profiles/$id/',
      fromJson: Profile.fromJson,
    );
  }

  Future<Result<ProfilePatchResponse, StirError>> patchProfile(
    String id, {
    String? name,
    String? description,
    MultipartFile? picture,
    String? dateOfBirth,
  }) {
    final fields = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    };

    final files = {if (picture != null) 'picture': picture};

    return _client.patchMultipart<ProfilePatchResponse>(
      '/profiles/$id/',
      fields: fields,
      files: files,
      fromJson: ProfilePatchResponse.fromMap,
    );
  }

}
