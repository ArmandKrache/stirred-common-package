class RatingCreateRequest {
  final String drinkId;
  final int rating;
  final String comment;

  RatingCreateRequest({
    required this.drinkId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'drink_id': drinkId,
      'comment': comment,
      'rating': rating,
    };
  }
}

class RatingPatchRequest {
  final String id;
  final Map<String, dynamic> body;

  RatingPatchRequest({
    required this.id,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
    };
  }
}

class RatingDeleteRequest {
  final String id;

  RatingDeleteRequest({required this.id});
}