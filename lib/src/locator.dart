import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/apis/admin_api_service.dart';
import 'package:stirred_common_domain/src/data/repositories/api_repository_impl.dart';
import 'package:stirred_common_domain/src/data/apis/stirred_api_service.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/data/http_client.dart';
import 'package:stirred_common_domain/src/config.dart';

final adminHttpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient(baseUrl: baseStirredAdminUrl);
});

final stirredHttpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient(baseUrl: baseStirredApiUrl);
});

final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  return ApiRepositoryImpl(
    ref.watch(adminApiServiceProvider),
    ref.watch(stirredApiServiceProvider),
  );
});