import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';
import 'package:stirred_common_domain/src/utils/resources/tokens_management.dart';

class TokenManager extends StateNotifier<ApiRepository?> {
  TokenManager() : super(null);

  void updateRepository(ApiRepository repository) {
    state = repository;
  }

  Future<String?> getAuthorizationHeader() async {
    final token = await readAccessToken();
    return token != null ? 'JWT $token' : null;
  }

  Future<bool> refreshTokens() async {
    if (state == null) {
      return false;
    }

    final refreshToken = await readRefreshToken();
    if (refreshToken == null) {
      return false;
    }

    final result = await state!.refreshToken(refreshToken: refreshToken);
    if (result is DataSuccess && result.data != null) {
      await saveAccessToken(result.data!.access);
      return true;
    }

    return false;
  }

  Future<void> clearTokens() async {
    await deleteTokens();
  }
} 