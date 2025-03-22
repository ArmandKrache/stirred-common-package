// ignore: unused_import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/data/http_client.dart';
import 'package:stirred_common_domain/src/domain/repositories/api_repository.dart';
import 'package:stirred_common_domain/src/locator.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> storeAccessToken(String token) async {
  await storage.write(key: 'access_token', value: token);
}

Future<void> storeRefreshToken(String token) async {
  await storage.write(key: 'refresh_token', value: token);
}

// Retrieve access token
Future<String?> getAccessToken() async {
  return await storage.read(key: 'access_token');
}

Future<String?> getRefreshToken() async {
  return await storage.read(key: 'refresh_token');
}

// Remove access token
Future<void> deleteTokens() async {
  await storage.delete(key: 'access_token');
  await storage.delete(key: 'refresh_token');
}

Future<String?> refreshToken(ApiRepository apiRepository) async {
  String? token = await getRefreshToken();
  if (token == null) {
    return null;
  }
  final refreshResponse = await apiRepository.refreshToken(refreshToken: token);
  if (refreshResponse is DataSuccess) {
    await storeAccessToken(refreshResponse.data!.access);
    return await getAccessToken();
  }
  return null;
}

class TokenInterceptor {
  final HttpClient client;
  final ApiRepository apiRepository;
  final Map<Uri, bool> isRefreshing = {};

  TokenInterceptor(this.client, this.apiRepository);

  Future<void> onRequest() async {
    final token = await getAccessToken();
    if (token != null) {
      client.setHeader('Authorization', 'JWT $token');
    }
  }

  Future<bool> onError(Uri uri, int statusCode) async {
    if (statusCode == 401) {
      // Ensure that the refresh for this URI is not already in progress
      if (isRefreshing[uri] == null) {
        isRefreshing[uri] = true;
        final refreshedAccessToken = await refreshToken(apiRepository);
        isRefreshing[uri] = false;

        if (refreshedAccessToken != null) {
          client.setHeader('Authorization', 'JWT $refreshedAccessToken');
          isRefreshing.remove(uri);
          return true; // Retry the request
        }
      }
    }
    return false; // Don't retry the request
  }
}

final tokenInterceptorProvider = Provider.family<TokenInterceptor, HttpClient>((ref, client) {
  return TokenInterceptor(
    client,
    ref.watch(apiRepositoryProvider),
  );
});
