import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:equatable/equatable.dart';

class ProfileCreateResponse extends Equatable {
  final Profile profile;


  const ProfileCreateResponse({
    required this.profile,
  });


  factory ProfileCreateResponse.fromMap(Map<String, dynamic> map) {
    logger.d(map);
    return ProfileCreateResponse(
        profile: Profile.fromJson(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [profile];

}