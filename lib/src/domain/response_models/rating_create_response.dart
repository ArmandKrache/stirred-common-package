
import 'package:stirred_common_domain/src/domain/models/rating/rating.dart';
import 'package:equatable/equatable.dart';

class RatingCreateResponse extends Equatable {
  final Rating rating;


  const RatingCreateResponse({
    required this.rating,
  });


  factory RatingCreateResponse.fromMap(Map<String, dynamic> map) {
    return RatingCreateResponse(
        rating: Rating.fromJson(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [rating];

}