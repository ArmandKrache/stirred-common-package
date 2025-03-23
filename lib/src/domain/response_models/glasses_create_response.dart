
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:equatable/equatable.dart';

class GlassesCreateResponse extends Equatable {
  final Glass glass;

  const GlassesCreateResponse({
    required this.glass,
  });


  factory GlassesCreateResponse.fromMap(Map<String, dynamic> map) {
    return GlassesCreateResponse(
      glass: Glass.fromJson(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [glass];

}