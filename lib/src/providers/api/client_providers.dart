import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/http_base_client.dart';
import 'package:stirred_common_domain/src/data/http_error_client.dart';
import 'package:stirred_common_domain/src/utils/interceptors/error_interceptor.dart';
import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/providers/auth/token_providers.dart';

/// Base HTTP client for admin API requests.
/// Handles token management and basic HTTP operations.
final _adminBaseClientProvider = Provider<HttpBaseClient>((ref) {
  final client = HttpBaseClient(
    baseUrl: baseStirredAdminUrl,
    tokenManager: ref.watch(tokenManagerProvider.notifier),
  );
  ref.onDispose(() => client.dispose());
  return client;
});

/// Base HTTP client for stirred API requests.
/// Handles token management and basic HTTP operations.
final _stirredBaseClientProvider = Provider<HttpBaseClient>((ref) {
  final client = HttpBaseClient(
    baseUrl: baseStirredApiUrl,
    tokenManager: ref.watch(tokenManagerProvider.notifier),
  );
  ref.onDispose(() => client.dispose());
  return client;
});

/// Error interceptor for admin API requests.
/// Handles error responses and token refresh for admin endpoints.
final _adminErrorInterceptorProvider = Provider<ErrorInterceptor>((ref) {
  return ErrorInterceptor(ref.watch(tokenManagerProvider.notifier));
});

/// Error interceptor for stirred API requests.
/// Handles error responses and token refresh for stirred endpoints.
final _stirredErrorInterceptorProvider = Provider<ErrorInterceptor>((ref) {
  return ErrorInterceptor(ref.watch(tokenManagerProvider.notifier));
});

/// HTTP client with error handling for admin API requests.
/// Combines base client functionality with error handling and retry logic.
final adminHttpClientProvider = Provider<HttpErrorClient>((ref) {
  return HttpErrorClient(
    client: ref.watch(_adminBaseClientProvider),
    errorInterceptor: ref.watch(_adminErrorInterceptorProvider),
  );
});

/// HTTP client with error handling for stirred API requests.
/// Combines base client functionality with error handling and retry logic.
final stirredHttpClientProvider = Provider<HttpErrorClient>((ref) {
  return HttpErrorClient(
    client: ref.watch(_stirredBaseClientProvider),
    errorInterceptor: ref.watch(_stirredErrorInterceptorProvider),
  );
}); 