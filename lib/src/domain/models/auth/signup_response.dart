import 'package:equatable/equatable.dart';
import 'package:stirred_common_domain/src/config.dart';

class SignupResponse extends Equatable {
  final String access;
  final String refresh;

  const SignupResponse({
    required this.access,
    required this.refresh,
  });


  factory SignupResponse.fromMap(Map<String, dynamic> map) {
    logger.d(map);
    return SignupResponse(
      access: map['access'] ?? "",
      refresh: map['refresh'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [access, refresh];

}