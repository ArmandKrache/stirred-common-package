import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:equatable/equatable.dart';

class DrinksListResponse extends Equatable {
  final List<Drink> drinks;


  const DrinksListResponse({
    required this.drinks,
  });


  factory DrinksListResponse.fromMap(Map<String, dynamic> map) {
    return DrinksListResponse(
      drinks: List<Drink>.from((map['results'] ?? []).map<dynamic>((element) {
        return Drink.fromJson(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [drinks];

}