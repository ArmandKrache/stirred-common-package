import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';
import 'package:stirred_common_domain/src/utils/interceptors/error_interceptor.dart';
import 'package:stirred_common_domain/src/data/http_base_client.dart';

class HttpErrorClient {
  final HttpBaseClient client;
  final ErrorInterceptor errorInterceptor;

  HttpErrorClient({
    required this.client,
    required this.errorInterceptor,
  });

  Future<DataState<T>> _handleResponse<T>(
    Uri uri,
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) async {
    final interceptorResponse = await errorInterceptor.onResponse(uri, response);
    if (interceptorResponse.shouldRetry) {
      // Retry the request with updated token
      final retryResponse = await client.get(uri.path);
      return _handleResponse(uri, retryResponse, fromJson);
    }

    if (!interceptorResponse.isSuccess) {
      return DataFailed(Exception(interceptorResponse.message));
    }

    if (response.body.isEmpty) {
      return DataSuccess(null as T);
    }

    try {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (fromJson != null) {
        return DataSuccess(fromJson(jsonData));
      }
      return DataSuccess(jsonData as T);
    } catch (e) {
      return DataFailed(Exception('Failed to parse response: ${e.toString()}'));
    }
  }

  Future<DataState<T>> get<T>(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        headers: headers,
      );
      return await _handleResponse(
        Uri.parse(client.baseUrl + path),
        response,
        fromJson,
      );
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }

  Future<DataState<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await client.post(
        path,
        body: body,
        headers: headers,
      );
      return await _handleResponse(
        Uri.parse(client.baseUrl + path),
        response,
        fromJson,
      );
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }

  Future<DataState<T>> postMultipart<T>(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, http.MultipartFile> files,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await client.postMultipart(
        path,
        fields: fields,
        files: files,
        headers: headers,
      );
      return await _handleResponse(
        Uri.parse(client.baseUrl + path),
        response,
        fromJson,
      );
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }

  Future<DataState<T>> patch<T>(
    String path, {
    dynamic body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await client.patch(
        path,
        body: body,
        headers: headers,
      );
      return await _handleResponse(
        Uri.parse(client.baseUrl + path),
        response,
        fromJson,
      );
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }

  Future<DataState<T>> patchMultipart<T>(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, http.MultipartFile>? files,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await client.patchMultipart(
        path,
        fields: fields,
        files: files,
        headers: headers,
      );
      return await _handleResponse(
        Uri.parse(client.baseUrl + path),
        response,
        fromJson,
      );
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }

  Future<DataState<T>> delete<T>(
    String path, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await client.delete(
        path,
        headers: headers,
      );
      return await _handleResponse(
        Uri.parse(client.baseUrl + path),
        response,
        fromJson,
      );
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }
} 