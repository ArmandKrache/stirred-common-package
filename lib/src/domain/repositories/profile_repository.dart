import 'package:http/http.dart';
import 'package:stirred_common_domain/src/data/apis/profile_api.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_create_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_list_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/profile_patch_response.dart';
import 'package:stirred_common_domain/src/utils/resources/result.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';

class ProfileRepository {
  ProfileRepository({
    required this.profileApi,
  });

  final ProfileApi profileApi;

  Future<Result<Profile, StirError>> getSelfProfile() async {
    /// TODO: Implement caching.
    return profileApi.getSelfProfile();
  }

  Future<Result<ProfileListResponse, StirError>> getProfilesList({
    int page = 1,
    int pageSize = 20,
  }) async {
    return profileApi.getProfileList(page: page, pageSize: pageSize);
  }

  Future<Result<Profile, StirError>> getProfileById(String id) async {
    return profileApi.retrieveProfile(id);
  }

  Future<Result<ProfileCreateResponse, StirError>> createProfile({
    required String user,
    required String name,
    required String description,
    required MultipartFile picture,
    required String dateOfBirth,
  }) async {
    return profileApi.createProfile(
      user: user,
      name: name,
      description: description,
      picture: picture,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<Result<ProfilePatchResponse, StirError>> updateProfile({
    required String id,
    String? email,
    String? name,
    String? description,
    MultipartFile? picture,
    String? dateOfBirth,
  }) async {
    return profileApi.patchProfile(id,
      email: email,
      name: name,
      description: description,
      picture: picture,
      dateOfBirth: dateOfBirth,
    );
  }
}

