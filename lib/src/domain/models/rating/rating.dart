import 'package:stirred_common_domain/src/domain/models/generic_data_model.dart';
import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String id;
  final String username;
  final String userPicture;
  final String comment;
  final int rating;
  final int upvotes;
  final DateTime creationTime;

  const Rating({
    required this.id,
    required this.username,
    required this.userPicture,
    required this.comment,
    required this.rating,
    required this.upvotes,
    required this.creationTime,
  });

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id'] ?? "",
      username : map['user']?['name'] ?? "",
      userPicture : map['user']?['picture'] ?? "",
      comment: map['comment'] ?? "",
      rating: map['rating'] ?? 0,
      upvotes: map['upvotes'] ?? 0,
      creationTime: map['creation_date'] == null ? DateTime.now() : DateTime.parse(map['creation_date']),
    );
  }

  factory Rating.empty() {
    return Rating(
      id: "",
      username : "",
      userPicture: "",
      comment: "",
      rating: 0,
      upvotes: 0,
      creationTime: DateTime.now(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, rating, username];

}