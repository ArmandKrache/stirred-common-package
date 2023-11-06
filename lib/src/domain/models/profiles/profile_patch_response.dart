import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:equatable/equatable.dart';

class ProfilePatchResponse extends Equatable {
  final Profile profile;


  const ProfilePatchResponse({
    required this.profile,
  });


  factory ProfilePatchResponse.fromMap(Map<String, dynamic> map) {
    logger.d(map);
    return ProfilePatchResponse(
        profile: Profile.fromMap(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [profile];

}