import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/token_manager.dart';

/// Provides token management functionality throughout the app.
/// This provider maintains the state of the API repository for token refresh operations.
final tokenManagerProvider = StateNotifierProvider<TokenManager, ApiRepository?>((ref) {
  return TokenManager();
}); 