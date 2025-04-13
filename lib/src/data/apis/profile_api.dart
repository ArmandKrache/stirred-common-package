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
  final String urlPrefix;

  ProfileApi(this._client, {this.urlPrefix = ''});

  Future<Result<Profile, StirError>> getSelfProfile() {
    return _client.get<Profile>(
      '$urlPrefix/self/',
      fromJson: Profile.fromJson,
    );
  }

  Future<Result<ProfileListResponse, StirError>> getProfileList() {
    return _client.get<ProfileListResponse>(
      '$urlPrefix/profiles/',
      fromJson: ProfileListResponse.fromMap,
    );
  }

  Future<Result<ProfileListResponse, StirError>> searchProfiles({String? query}) {
    return _client.get<ProfileListResponse>(
      '$urlPrefix/profiles/search/',
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
      '$urlPrefix/profiles/create/',
      fields: fields,
      files: files,
      fromJson: ProfileCreateResponse.fromMap,
    );
  }

  Future<Result<Profile, StirError>> retrieveProfile(String id) {
    return _client.get<Profile>(
      '$urlPrefix/profiles/$id/',
      fromJson: Profile.fromJson,
    );
  }

  Future<Result<ProfilePatchResponse, StirError>> patchProfile(
    String id, {
    String? email,
    String? name,
    String? description,
    MultipartFile? picture,
    String? dateOfBirth,
  }) {
    final fields = {
      if (email != null) 'user.email': email,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    };

    final files = {if (picture != null) 'picture': picture};

    return _client.patchMultipart<ProfilePatchResponse>(
      '$urlPrefix/profiles/$id/',
      fields: fields,
      files: files,
      fromJson: ProfilePatchResponse.fromMap,
    );
  }
}
