import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stirred_common_domain/src/data/http/base_client.dart';
import 'package:stirred_common_domain/src/utils/resources/result.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';
import 'package:stirred_common_domain/src/utils/resources/token_manager.dart';

/// HTTP client that handles error responses and token refresh.
/// This class wraps the base client and adds error handling capabilities.
class ErrorHandlingClient {
  final BaseClient _client;
  final TokenManager _tokenManager;

  ErrorHandlingClient({
    required BaseClient client,
    required TokenManager tokenManager,
  }) : _client = client,
       _tokenManager = tokenManager;

  /// Handles the response from an HTTP request.
  Future<Result<T, StirError>> _handleResponse<T>(
    Future<http.Response> Function() request,
    T Function(Map<String, dynamic>)? fromJson,
  ) async {
    try {
      var response = await request();
      var retryCount = 0;
      const maxRetries = 1;

      while (response.statusCode == 401 && retryCount < maxRetries) {
        final refreshed = await _tokenManager.refreshTokens();
        if (!refreshed) {
          break;
        }
        response = await request();
        retryCount++;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return Result.success(null as T);
        }

        try {
          final utf8Bytes = response.bodyBytes;
          final utf8String = utf8.decode(utf8Bytes);
          final Map<String, dynamic> jsonData = jsonDecode(utf8String);
          
          if (fromJson != null) {
            return Result.success(fromJson(jsonData));
          }
          return Result.success(jsonData as T);
        } catch (e) {
          return Result.failure(StirError(500, message: 'Failed to parse response: ${e.toString()}'));
        }
      }

      return Result.failure(StirError(response.statusCode, message: response.body));
    } catch (e) {
      return Result.failure(StirError(500, message: e.toString()));
    }
  }

  /// Makes a GET request with error handling.
  Future<Result<T, StirError>> get<T>(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.get(path, queryParameters: queryParameters, headers: headers),
      fromJson,
    );
  }

  /// Makes a POST request with error handling.
  Future<Result<T, StirError>> post<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.post(path, body: body, headers: headers),
      fromJson,
    );
  }

  /// Makes a multipart POST request with error handling.
  Future<Result<T, StirError>> postMultipart<T>(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, http.MultipartFile> files,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.postMultipart(
        path,
        fields: fields,
        files: files,
        headers: headers,
      ),
      fromJson,
    );
  }

  /// Makes a PUT request with error handling.
  Future<Result<T, StirError>> put<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.put(path, body: body, headers: headers),
      fromJson,
    );
  }

  /// Makes a PATCH request with error handling.
  Future<Result<T, StirError>> patch<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.patch(path, body: body, headers: headers),
      fromJson,
    );
  }

  /// Makes a multipart PATCH request with error handling.
  Future<Result<T, StirError>> patchMultipart<T>(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, http.MultipartFile> files,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.patchMultipart(
        path,
        fields: fields,
        files: files,
        headers: headers,
      ),
      fromJson,
    );
  }

  /// Makes a DELETE request with error handling.
  Future<Result<T, StirError>> delete<T>(
    String path, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleResponse(
      () => _client.delete(path, headers: headers),
      fromJson,
    );
  }

  /// Closes the underlying HTTP client.
  void dispose() {
    _client.dispose();
  }
} 