import 'package:dio/dio.dart';
import 'package:stirred_common_domain/src/config.dart';

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

class TokenInterceptor extends Interceptor {

  @override
  Future onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await getAccessToken();
    options.headers['Authorization'] = 'JWT $token';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) => super.onResponse(response, handler);

  @override
  Future onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    super.onError(err, handler);
  }
}