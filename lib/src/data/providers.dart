import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/apis/admin_api.dart';
import 'package:stirred_common_domain/src/data/apis/drinks_api.dart';
import 'package:stirred_common_domain/src/data/apis/profile_api.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/shared_preferences.dart';
import 'package:stirred_common_domain/src/data/http/base_client.dart';
import 'package:stirred_common_domain/src/data/http/error_handling_client.dart';
import 'package:stirred_common_domain/src/utils/interceptors/error_interceptor.dart';
import 'package:stirred_common_domain/src/utils/resources/token_manager.dart';

/// Token Manager

final tokenManagerProvider = Provider<TokenManager>((ref) {
  return TokenManager();
});

/// Cache 

final sharedPreferencesStorageProvider = Provider<SharedPreferencesStorage>((ref) {
  return SharedPreferencesStorage();
});

/// HTTP Client & Interceptors

final _baseClientProvider = Provider<BaseClient>((ref) {
  return BaseClient(
    baseUrl: 'https://127.0.0.1:8000',
    tokenManager: ref.watch(tokenManagerProvider),
  );
});

final errorInterceptorProvider = Provider<ErrorInterceptor>((ref) {
  return ErrorInterceptor(ref.watch(tokenManagerProvider));
});

final httpClientProvider = Provider<ErrorHandlingClient>((ref) {
  return ErrorHandlingClient(
    client: ref.watch(_baseClientProvider),
    tokenManager: ref.watch(tokenManagerProvider),
  );
});

/// API Services

final authApiServiceProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(httpClientProvider));
});

final profileApiServiceProvider = Provider<ProfileApi>((ref) {
  return ProfileApi(ref.watch(httpClientProvider), urlPrefix: '/api');
});

final drinksApiServiceProvider = Provider<DrinksApi>((ref) {
  return DrinksApi(ref.watch(httpClientProvider), urlPrefix: '/api');
});
