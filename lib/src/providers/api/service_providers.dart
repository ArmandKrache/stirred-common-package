import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/apis/admin_api_service.dart';
import 'package:stirred_common_domain/src/data/apis/stirred_api_service.dart';
import 'package:stirred_common_domain/src/providers/api/client_providers.dart';

/// Provider for the admin API service.
/// Uses the admin HTTP client with error handling for all admin-related API operations.
final adminApiServiceProvider = Provider<AdminApiService>((ref) {
  return AdminApiService(ref.watch(adminHttpClientProvider));
});

/// Provider for the stirred API service.
/// Uses the stirred HTTP client with error handling for all stirred-related API operations.
final stirredApiServiceProvider = Provider<StirredApiService>((ref) {
  return StirredApiService(ref.watch(stirredHttpClientProvider));
}); 