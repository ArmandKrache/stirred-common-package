import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';
import 'package:stirred_common_domain/src/utils/resources/token_storage.dart';

/// Manages authentication tokens and handles token refresh operations.
/// 
/// This class combines token storage with refresh logic, providing a clean interface
/// for token management throughout the app.
class TokenManager extends StateNotifier<ApiRepository?> {
  final TokenStorage _storage;
  
  /// Creates a new [TokenManager] instance.
  /// 
  /// Optionally accepts a custom [TokenStorage] implementation for testing.
  TokenManager([TokenStorage? storage]) 
    : _storage = storage ?? TokenStorage(),
      super(null);

  /// Updates the repository used for token refresh operations.
  void updateRepository(ApiRepository repository) {
    state = repository;
  }

  /// Gets the authorization header value for API requests.
  /// 
  /// Returns a header in the format "JWT <token>" if a token exists,
  /// otherwise returns null.
  Future<String?> getAuthorizationHeader() async {
    final token = await _storage.getAccessToken();
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

    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) {
      return false;
    }

    final result = await state!.refreshToken(refreshToken: refreshToken);
    if (result is DataSuccess && result.data != null) {
      return await _storage.storeAccessToken(result.data!.access);
    }

    return false;
  }

  /// Stores both access and refresh tokens.
  /// 
  /// Returns true if both tokens were successfully stored.
  Future<bool> storeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final results = await Future.wait([
      _storage.storeAccessToken(accessToken),
      _storage.storeRefreshToken(refreshToken),
    ]);
    
    return results.every((success) => success);
  }

  /// Clears all stored tokens.
  /// 
  /// Returns true if the operation was successful.
  Future<bool> clearTokens() async {
    return await _storage.clearTokens();
  }

  /// Checks if the user has valid tokens stored.
  /// 
  /// Returns true if both access and refresh tokens exist.
  Future<bool> hasValidTokens() async {
    return await _storage.hasTokens();
  }
} 