import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/apis/admin_api_service.dart';
import 'package:stirred_common_domain/src/data/repositories/api_repository_impl.dart';
import 'package:stirred_common_domain/src/data/apis/stirred_api_service.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/data/http_base_client.dart';
import 'package:stirred_common_domain/src/data/http_error_client.dart';
import 'package:stirred_common_domain/src/utils/interceptors/error_interceptor.dart';
import 'package:stirred_common_domain/src/config.dart';

// Base HTTP clients
final _adminBaseClientProvider = Provider<HttpBaseClient>((ref) {
  final client = HttpBaseClient(baseUrl: baseStirredAdminUrl);
  ref.onDispose(() => client.dispose());
  return client;
});

final _stirredBaseClientProvider = Provider<HttpBaseClient>((ref) {
  final client = HttpBaseClient(baseUrl: baseStirredApiUrl);
  ref.onDispose(() => client.dispose());
  return client;
});

// Error interceptors
final errorInterceptorProvider = Provider.family<ErrorInterceptor, ApiRepository?>((ref, repository) {
  return ErrorInterceptor(repository);
});

// Error handling clients
final adminHttpClientProvider = Provider<HttpErrorClient>((ref) {
  return HttpErrorClient(
    client: ref.watch(_adminBaseClientProvider),
    errorInterceptor: ref.watch(errorInterceptorProvider(null)),
  );
});

final stirredHttpClientProvider = Provider<HttpErrorClient>((ref) {
  return HttpErrorClient(
    client: ref.watch(_stirredBaseClientProvider),
    errorInterceptor: ref.watch(errorInterceptorProvider(null)),
  );
});

// API services
final adminApiServiceProvider = Provider<AdminApiService>((ref) {
  return AdminApiService(ref.watch(adminHttpClientProvider));
});

final stirredApiServiceProvider = Provider<StirredApiService>((ref) {
  return StirredApiService(ref.watch(stirredHttpClientProvider));
});

// API repository
final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  final repository = ApiRepositoryImpl(
    ref.watch(adminApiServiceProvider),
    ref.watch(stirredApiServiceProvider),
  );

  // Update error interceptors with the repository
  ref.read(errorInterceptorProvider(null)).updateRepository(repository);

  return repository;
}); 