
import 'package:stirred_common_domain/src/domain/models/rating/rating.dart';
import 'package:equatable/equatable.dart';

class RatingPatchResponse extends Equatable {
  final Rating rating;


  const RatingPatchResponse({
    required this.rating,
  });


  factory RatingPatchResponse.fromMap(Map<String, dynamic> map) {
    return RatingPatchResponse(
        rating: Rating.fromJson(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [rating];

}