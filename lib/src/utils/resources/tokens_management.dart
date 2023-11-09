import 'package:dio/dio.dart';
import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/data/api_repository_impl.dart';
import 'package:stirred_common_domain/src/domain/api_repository.dart';
import 'package:stirred_common_domain/src/locator.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

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

Future<String?> refreshToken() async {
  String? token = await getRefreshToken();
  if (token == null) {
    return null;
  }
  final refreshResponse = await locator<ApiRepository>().refreshToken(refreshToken: token);
  if (refreshResponse is DataSuccess) {
    await storeAccessToken(refreshResponse.data!.access);
    return await getAccessToken();
  }
  return null;
}

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final Map<Uri, bool> isRefreshing = {};

  TokenInterceptor() : dio = Dio();


  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'JWT $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      final originalRequest = err.requestOptions;
      final uri = originalRequest.uri;

      logger.d(isRefreshing[uri]);

      // Ensure that the refresh for this URI is not already in progress
      if (isRefreshing[uri] == null) {
        isRefreshing[uri] = true;
        final refreshedAccessToken = await refreshToken();

        // Mark the refresh as completed
        isRefreshing[uri] = false;

        if (refreshedAccessToken != null) {
          // Retry the original request with the new token
          originalRequest.headers['Authorization'] = 'JWT $refreshedAccessToken';

          try {
            final response = await dio.fetch(originalRequest);
            handler.resolve(response);
            return;
          } catch (e) {
            /// Handle any errors during the retry, if needed
          }
        }
      }
    }
    super.onError(err, handler);
  }
}

/*class TokenInterceptor extends Interceptor {
  final int maxRetries;

  TokenInterceptor({this.maxRetries = 3});


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

  /*
  @override
  Future onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    Dio dio = Dio();
    if (err.response?.statusCode == 401) {
      try {
        final refreshedAccessToken = await refreshToken();
        if (refreshedAccessToken != null) {
          // Retry the original request with the new token
          final newOptions = err.requestOptions
            ..headers['Authorization'] = 'JWT $refreshedAccessToken';
          final response = await dio.fetch(newOptions);
          logger.d("on Error : ");
          logger.d(response);
          handler.resolve(response);
        } else {
          handler.reject(err);
        }
      } catch (e) {
        handler.reject(err);
      }
    } else {
      super.onError(err, handler);
    }
  }*/

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Dio dio = Dio();
    if (err.response?.statusCode == 401) {
      int retryCount = 0;
      while (retryCount < maxRetries) {
        try {
          final refreshedToken = await refreshToken(); // Implement your token refresh logic
          if (refreshedToken != null) {
            // Retry the original request with the new token
            final newOptions = err.requestOptions
              ..headers['Authorization'] = 'JWT $refreshedToken';
            final response = await dio.fetch(newOptions);
            handler.resolve(response);
            return;
          } else {
            handler.reject(err);
            return;
          }
        } catch (e) {
          retryCount++;
          if (retryCount >= maxRetries) {
            handler.reject(err);
          }
        }
      }
    } else {
      super.onError(err, handler);
    }
  }
}*/
