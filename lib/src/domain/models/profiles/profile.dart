import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/domain/models/preferences.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    @JsonKey(readValue: _readEmail) @Default("") String email,
    @Default("") String name,
    @Default("") String description,
    @Default("") String picture,
    @JsonKey(name: 'date_of_birth') @Default("") String dateOfBirth,
    @Default(Preferences()) Preferences preferences,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

Object? _readEmail(Map<dynamic, dynamic> json, String key) {
  return (json['user'] as Map<String, dynamic>?)?['email'];
}