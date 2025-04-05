import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/apis/profile_api.dart';
import 'package:stirred_common_domain/src/data/cache/secure_storage/shared_preferences.dart';
import 'package:stirred_common_domain/src/data/http_base_client.dart';
import 'package:stirred_common_domain/src/data/http_error_client.dart';
import 'package:stirred_common_domain/src/utils/interceptors/error_interceptor.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

final tokenManagerProvider = Provider<TokenManager>((ref) {
  return TokenManager();
});

final sharedPreferencesStorageProvider = Provider<SharedPreferencesStorage>((ref) {
  return SharedPreferencesStorage();
});

final httpClientProvider = Provider<HttpBaseClient>((ref) {
  return HttpBaseClient(
    baseUrl: 'https://api.stirred.com',
    tokenManager: ref.watch(tokenManagerProvider),
  );
});

final errorInterceptorProvider = Provider<ErrorInterceptor>((ref) {
  return ErrorInterceptor(ref.watch(tokenManagerProvider));
});

final httpRestClientProvider = Provider<HttpRestClient>((ref) {
  return HttpRestClient(
    client: ref.watch(httpClientProvider),
    errorInterceptor: ref.watch(errorInterceptorProvider),
  );
});

final adminApiServiceProvider = Provider<AdminApiService>((ref) {
  return AdminApiService(ref.watch(httpRestClientProvider));
});

final profileApiServiceProvider = Provider<ProfileApi>((ref) {
  return ProfileApi(ref.watch(httpRestClientProvider));
});
