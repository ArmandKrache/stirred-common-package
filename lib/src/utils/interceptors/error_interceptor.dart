import 'package:http/http.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';
import 'package:stirred_common_domain/src/utils/resources/tokens_management.dart';

class ErrorResponse {
  final bool shouldRetry;
  final String? errorMessage;

  const ErrorResponse({
    required this.shouldRetry,
    this.errorMessage,
  });
}

class ErrorInterceptor {
  ApiRepository? _repository;

  ErrorInterceptor([ApiRepository? repository]) : _repository = repository;

  void updateRepository(ApiRepository repository) {
    _repository = repository;
  }

  Future<ErrorResponse> onError(Uri uri, Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return const ErrorResponse(shouldRetry: false);
    }

    switch (response.statusCode) {
      case 401:
        if (_repository == null) {
          return const ErrorResponse(
            shouldRetry: false,
            errorMessage: 'Authentication required',
          );
        }
        
        final refreshResult = await _repository!.refreshToken(
          refreshToken: await readRefreshToken() ?? '',
        );
        
        if (refreshResult is DataSuccess && refreshResult.data != null) {
          await saveAccessToken(refreshResult.data!.access);
          return const ErrorResponse(shouldRetry: true);
        }
        
        return const ErrorResponse(
          shouldRetry: false,
          errorMessage: 'Session expired. Please log in again.',
        );

      case 429:
        return const ErrorResponse(
          shouldRetry: false,
          errorMessage: 'Too many requests. Please try again later.',
        );

      default:
        if (response.statusCode >= 500) {
          return const ErrorResponse(
            shouldRetry: false,
            errorMessage: 'Server error. Please try again later.',
          );
        }
        
        return const ErrorResponse(
          shouldRetry: false,
          errorMessage: 'Request failed',
        );
    }
  }
} 