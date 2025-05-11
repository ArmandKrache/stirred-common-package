
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:equatable/equatable.dart';

class GlassesListResponse extends Equatable {
  final List<Glass> glasses;


  const GlassesListResponse({
    required this.glasses,
  });


  factory GlassesListResponse.fromMap(Map<String, dynamic> map) {
    return GlassesListResponse(
      glasses: List<Glass>.from((map['results'] ?? []).map<dynamic>((element) {
        return Glass.fromJson(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [glasses];

}