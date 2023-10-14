
import 'package:stirred_common_domain/src/domain/models/glasses/glass.dart';
import 'package:equatable/equatable.dart';

class GlassPatchResponse extends Equatable {
  final Glass glass;

  const GlassPatchResponse({
    required this.glass,
  });


  factory GlassPatchResponse.fromMap(Map<String, dynamic> map) {
    return GlassPatchResponse(
        glass: Glass.fromMap(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [glass];

}