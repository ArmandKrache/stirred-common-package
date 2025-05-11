import 'package:stirred_common_domain/src/data/http/error_handling_client.dart';
import 'package:stirred_common_domain/src/domain/response_models/signup_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/login_response.dart';
import 'package:stirred_common_domain/src/utils/resources/result.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';

class AuthApi {
  final ErrorHandlingClient _client;

  AuthApi(this._client);

  Future<Result<SignupResponse, StirError>> signup(Map<String, String> body) {
    return _client.post<SignupResponse>(
      '/auth/signup/',
      body: body,
      fromJson: SignupResponse.fromMap,
    );
  }

  Future<Result<LoginResponse, StirError>> login(Map<String, dynamic> credentials) {
    return _client.post<LoginResponse>(
      '/auth/token/login/',
      body: credentials,
      fromJson: LoginResponse.fromMap,
    );
  }

  Future<Result<void, StirError>> verifyToken(Map<String, dynamic> token) {
    return _client.post<void>(
      '/auth/token/verify/',
      body: token,
    );
  }

  Future<Result<LoginResponse, StirError>> refreshToken(Map<String, dynamic> token) {
    return _client.post<LoginResponse>(
      '/auth/token/refresh/',
      body: token,
      fromJson: LoginResponse.fromMap,
    );
  }

  Future<Result<dynamic, StirError>> checkUsernameValidity(Map<String, dynamic> body) {
    return _client.post(
      '/auth/check-username/',
      body: body,
    );
  }
}
