// ignore_for_file: unused_import

import 'package:stirred_common_domain/src/domain/models/preferences.dart';
import 'package:stirred_common_domain/src/domain/models/profiles/profile.dart';
import 'package:equatable/equatable.dart';

class ProfileListResponse extends Equatable {
  final List<Profile> profiles;


  const ProfileListResponse({
    required this.profiles,
  });


  factory ProfileListResponse.fromMap(Map<String, dynamic> map) {
    return ProfileListResponse(
      profiles: List<Profile>.from((map['results'] ?? []).map<dynamic>((element) {
        return Profile.fromJson(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [profiles];

}