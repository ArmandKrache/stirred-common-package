import 'dart:async';

import 'package:stirred_common_domain/src/data/cache/secure_storage/secure_storage.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/shared_preferences.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

/// A repository allowing to perform various operations related to devices.
class AdminRepository {
  AdminRepository({
    required this.adminApiService,
    required this.sharedPreferencesStorage,
  });

  /// The [AdminApiService] API data source.
  final AdminApiService adminApiService;

  /// The [SecureStorage] encrypted cache data source.
  final SharedPreferencesStorage sharedPreferencesStorage;

  /// Fetch the auth token from the cache.
  Future<String?> readAuthToken() async {
    return sharedPreferencesStorage.read<String>(PreferencesKeys.authToken.value);
  }

  /// Save the auth token in the cache.
  Future<bool> saveAuthToken(String authToken) async {
    return sharedPreferencesStorage.save<String>(PreferencesKeys.authToken.value, authToken);
  }

  /// Remove the auth token from the cache.
  Future<bool> removeAuthToken() async {
    return sharedPreferencesStorage.remove(PreferencesKeys.authToken.value);
  }

  /// Admin API implementation.

  Future<DataState<SignupResponse>> signup(Map<String, String> body) {
    return adminApiService.signup(body);
  }

  Future<DataState<LoginResponse>> login(Map<String, dynamic> credentials) {
    return adminApiService.login(credentials);
  }

  Future<DataState<void>> verifyToken(Map<String, dynamic> token) {
    return adminApiService.verifyToken(token);
  }

  Future<DataState<LoginResponse>> refreshToken(Map<String, dynamic> token) {
    return adminApiService.refreshToken(token);
  }

  Future<DataState<dynamic>> checkUsernameValidity(Map<String, dynamic> body) {
    return adminApiService.checkUsernameValidity(body);
  }
}
