import 'dart:async';

import 'package:stirred_common_domain/src/data/apis/admin_api.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/secure_storage.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/shared_preferences.dart';
import 'package:stirred_common_domain/src/domain/response_models/login_response.dart';
import 'package:stirred_common_domain/src/domain/response_models/signup_response.dart';
import 'package:stirred_common_domain/src/utils/resources/result.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';

/// A repository allowing to perform various operations related to devices.
class AuthRepository {
  AuthRepository({
    required this.authApi,
    required this.sharedPreferencesStorage,
  });

  /// The [AuthApi] API data source.
  final AuthApi authApi;

  /// The [SecureStorage] encrypted cache data source.
  final SharedPreferencesStorage sharedPreferencesStorage;

  /// Fetch the auth token from the cache.
  Future<String?> readAccessToken() async {
    return sharedPreferencesStorage.read<String>(PreferencesKeys.accessToken.value);
  }

  /// Save the auth token in the cache.
  Future<bool> saveAccessToken(String accessToken) async {
    return sharedPreferencesStorage.save<String>(PreferencesKeys.accessToken.value, accessToken);
  }

  /// Remove the auth token from the cache.
  Future<bool> removeAccessToken() async {
    return sharedPreferencesStorage.remove(PreferencesKeys.accessToken.value);
  }

  /// Save the refresh token in the cache.
  Future<bool> saveRefreshToken(String refreshToken) async {
    return sharedPreferencesStorage.save<String>(PreferencesKeys.refreshToken.value, refreshToken);
  }

  /// Remove the refresh token from the cache.
  Future<bool> removeRefreshToken() async {
    return sharedPreferencesStorage.remove(PreferencesKeys.refreshToken.value);
  }

  /// Fetch the refresh token from the cache.
  Future<String?> readRefreshToken() async {
    return sharedPreferencesStorage.read<String>(PreferencesKeys.refreshToken.value);
  }

  /// Admin API implementation.

  Future<Result<SignupResponse, StirError>> signup(Map<String, String> body) {
    return authApi.signup(body);
  }

  Future<Result<LoginResponse, StirError>> login(Map<String, dynamic> credentials) {
    return authApi.login(credentials);
  }

  Future<Result<void, StirError>> verifyToken(Map<String, dynamic> token) {
    return authApi.verifyToken(token);
  }

  Future<Result<LoginResponse, StirError>> refreshToken(Map<String, dynamic> token) {
    return authApi.refreshToken(token);
  }

  Future<Result<dynamic, StirError>> checkUsernameValidity(Map<String, dynamic> body) {
    return authApi.checkUsernameValidity(body);
  }
}
