import 'package:equatable/equatable.dart';
import 'package:stirred_common_domain/src/config.dart';

class LoginResponse extends Equatable {
  final String access;
  final String refresh;

  const LoginResponse({
    required this.access,
    required this.refresh,
  });


  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    logger.d(map);
    return LoginResponse(
      access: map['access'] ?? "",
      refresh: map['refresh'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [access, refresh];

}