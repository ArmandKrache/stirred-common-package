import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/data/repositories/api_repository_impl.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/providers/api/service_providers.dart';
import 'package:stirred_common_domain/src/providers/auth/token_providers.dart';

/// Provider for the main API repository.
/// Combines admin and stirred API services and updates the token manager with itself
/// for token refresh operations.
final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  final repository = ApiRepositoryImpl(
    ref.watch(adminApiServiceProvider),
    ref.watch(stirredApiServiceProvider),
  );
  
  // Update token manager with the repository for token refresh operations
  ref.read(tokenManagerProvider.notifier).updateRepository(repository);
  
  return repository;
}); 