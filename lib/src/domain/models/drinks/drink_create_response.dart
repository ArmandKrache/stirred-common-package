import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/domain/models/drinks/drink.dart';
import 'package:equatable/equatable.dart';

class DrinkCreateResponse extends Equatable {
  final Drink drink;


  const DrinkCreateResponse({
    required this.drink,
  });


  factory DrinkCreateResponse.fromMap(Map<String, dynamic> map) {
    logger.d(map);
    return DrinkCreateResponse(
      drink: Drink.fromJson(map),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [drink];

}