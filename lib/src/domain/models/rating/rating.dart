import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating.freezed.dart';
part 'rating.g.dart';

Object? _readUsername(Map<dynamic, dynamic> json, String key) {
  return (json['user'] as Map<String, dynamic>?)?['name'];
}

Object? _readUserPicture(Map<dynamic, dynamic> json, String key) {
  return (json['user'] as Map<String, dynamic>?)?['picture'];
}

@freezed
class Rating with _$Rating {
  const factory Rating({
    required String id,
    @JsonKey(readValue: _readUsername) required String username,
    @JsonKey(readValue: _readUserPicture) required String userPicture,
    required String comment,
    required int rating,
    required int upvotes,
    @JsonKey(name: 'creation_date') required DateTime creationTime,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}