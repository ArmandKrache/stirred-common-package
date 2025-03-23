import 'package:http/http.dart';
import 'package:stirred_common_domain/src/utils/resources/token_manager.dart';

class ErrorInterceptorResponse {
  final int statusCode;
  final bool isSuccess;
  final bool shouldRetry;
  final String message;

  ErrorInterceptorResponse({
    required this.statusCode,
    this.isSuccess = false,
    this.shouldRetry = false,
    this.message = '',
  });
}

class ErrorInterceptor {
  final TokenManager _tokenManager;

  ErrorInterceptor(this._tokenManager);

  Future<ErrorInterceptorResponse> onResponse(Uri uri, Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ErrorInterceptorResponse(isSuccess: true, statusCode: response.statusCode);
    }

    switch (response.statusCode) {
      case 401:
        final refreshed = await _tokenManager.refreshTokens();
        if (refreshed) {
          return ErrorInterceptorResponse(shouldRetry: true, statusCode: response.statusCode);
        }
        
        return ErrorInterceptorResponse(
          message: 'Session expired. Please log in again.',
          statusCode: response.statusCode,
        );

      case 429:
        return ErrorInterceptorResponse(
          message: 'Too many requests. Please try again later.',
          statusCode: response.statusCode,
        );

      default:
        if (response.statusCode >= 500) {
          return ErrorInterceptorResponse(
            message: 'Server error. Please try again later.',
            statusCode: response.statusCode,
          );
        }
        
        return ErrorInterceptorResponse(
          message: 'Request failed',
          statusCode: response.statusCode,
        );
    }
  }
} 