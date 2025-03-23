import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/domain/response_models/signup_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/login_response.dart';
import 'package:stirred_common_domain/src/data/http_client.dart';
import 'package:stirred_common_domain/src/providers.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

class AdminApiService {
  final HttpClient _client;

  AdminApiService(this._client);

  Future<DataState<SignupResponse>> signup(Map<String, String> body) {
    return _client.post<SignupResponse>(
      '/auth/signup/',
      body: body,
      fromJson: SignupResponse.fromMap,
    );
  }

  Future<DataState<LoginResponse>> getTokens(Map<String, dynamic> credentials) {
    return _client.post<LoginResponse>(
      '/auth/token/login/',
      body: credentials,
      fromJson: LoginResponse.fromMap,
    );
  }

  Future<DataState<void>> verifyToken(Map<String, dynamic> token) {
    return _client.post<void>(
      '/auth/token/verify/',
      body: token,
    );
  }

  Future<DataState<LoginResponse>> refreshToken(Map<String, dynamic> token) {
    return _client.post<LoginResponse>(
      '/auth/token/refresh/',
      body: token,
      fromJson: LoginResponse.fromMap,
    );
  }

  Future<DataState<dynamic>> checkUsernameValidity(Map<String, dynamic> body) {
    return _client.post(
      '/auth/check-username/',
      body: body,
    );
  }
}

final adminApiServiceProvider = Provider<AdminApiService>((ref) {
  return AdminApiService(ref.watch(adminHttpClientProvider));
});