import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/shared_preferences.dart';
import 'package:stirred_common_domain/src/domain/repositories/auth_repository.dart';

/// Manages authentication tokens and handles token refresh operations.
/// 
/// This class combines token storage with refresh logic, providing a clean interface
/// for token management throughout the app.
class TokenManager extends StateNotifier<AuthRepository?> {
  final SharedPreferencesStorage _storage;
  
  /// Creates a new [TokenManager] instance.
  /// 
  /// Optionally accepts a custom [TokenStorage] implementation for testing.
  TokenManager([SharedPreferencesStorage? storage]) 
    : _storage = storage ?? SharedPreferencesStorage(),
      super(null);

  /// Updates the repository used for token refresh operations.
  void updateRepository(AuthRepository repository) {
    state = repository;
  }

  /// Gets the authorization header value for API requests.
  /// 
  /// Returns a header in the format "JWT <token>" if a token exists,
  /// otherwise returns null.
  Future<String?> getAuthorizationHeader() async {
    final token = await _storage.read<String>(PreferencesKeys.accessToken.value);
    return token != null ? 'JWT $token' : null;
  }

  /// Attempts to refresh the access token using the stored refresh token.
  /// 
  /// Returns true if the refresh was successful and a new access token was stored.
  /// Returns false if:
  /// - No repository is available for refresh
  /// - No refresh token is stored
  /// - The refresh operation fails
  Future<bool> refreshTokens() async {
    if (state == null) {
      return false;
    }

    final refreshToken = await _storage.read<String>(PreferencesKeys.refreshToken.value);
    if (refreshToken == null) {
      return false;
    }

    final result = await state!.refreshToken({
      'refresh': refreshToken,
    });

    return result.when(
      success: (data) {
        return _storage.save<String>(PreferencesKeys.accessToken.value, data.access);
      },
      failure: (error) {
        return false;
      },
    );
  }

  /// Stores both access and refresh tokens.
  /// 
  /// Returns true if both tokens were successfully stored.
  Future<bool> storeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final results = await Future.wait([
      _storage.save<String>(PreferencesKeys.accessToken.value, accessToken),
      _storage.save<String>(PreferencesKeys.refreshToken.value, refreshToken),
    ]);
    
    return results.every((success) => success);
  }

  /// Clears all stored tokens.
  /// 
  /// Returns true if the operation was successful.
  Future<bool> clearTokens() async {
    return await _storage.remove(PreferencesKeys.accessToken.value) && await _storage.remove(PreferencesKeys.refreshToken.value);
  }

  /// Checks if the user has valid tokens stored.
  /// 
  /// Returns true if both access and refresh tokens exist.
  Future<bool> hasValidTokens() async {
    return await _storage.read<String>(PreferencesKeys.accessToken.value) != null && await _storage.read<String>(PreferencesKeys.refreshToken.value) != null;
  }
} 