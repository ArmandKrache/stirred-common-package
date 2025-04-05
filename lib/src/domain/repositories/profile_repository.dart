import 'package:http/http.dart';
import 'package:stirred_common_domain/src/data/apis/profile_api.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

class ProfileRepository {
  ProfileRepository({
    required this.profileApi,
  });

  final ProfileApi profileApi;

  Future<DataState<Profile>> getSelfProfile() async {
    /// TODO: Implement caching.
    return profileApi.getSelfProfile();
  }

  Future<DataState<Profile>> getProfileById(String id) async {
    return profileApi.retrieveProfile(id);
  }

  Future<DataState<ProfileCreateResponse>> createProfile({
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

  Future<DataState<ProfilePatchResponse>> updateProfile({
    required String id,
    String? name,
    String? description,
    MultipartFile? picture,
    String? dateOfBirth,
  }) async {
    return profileApi.patchProfile(id,
      name: name,
      description: description,
      picture: picture,
      dateOfBirth: dateOfBirth,
    );
  }
}

