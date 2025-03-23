import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Handles secure storage and retrieval of authentication tokens.
class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  
  final FlutterSecureStorage _storage;

  /// Creates a new [TokenStorage] instance.
  /// 
  /// By default, uses [FlutterSecureStorage], but can be provided with a custom
  /// storage implementation for testing or different storage strategies.
  TokenStorage([FlutterSecureStorage? storage]) 
    : _storage = storage ?? const FlutterSecureStorage();

  /// Stores the access token securely.
  /// 
  /// Returns true if the operation was successful.
  Future<bool> storeAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Stores the refresh token securely.
  /// 
  /// Returns true if the operation was successful.
  Future<bool> storeRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Retrieves the stored access token.
  /// 
  /// Returns null if no token is stored or if retrieval fails.
  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Retrieves the stored refresh token.
  /// 
  /// Returns null if no token is stored or if retrieval fails.
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  /// Deletes both access and refresh tokens.
  /// 
  /// Returns true if both tokens were successfully deleted.
  Future<bool> clearTokens() async {
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _refreshTokenKey),
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Checks if both tokens are present in storage.
  /// 
  /// Returns true if both access and refresh tokens exist.
  Future<bool> hasTokens() async {
    try {
      final access = await getAccessToken();
      final refresh = await getRefreshToken();
      return access != null && refresh != null;
    } catch (e) {
      return false;
    }
  }
} 