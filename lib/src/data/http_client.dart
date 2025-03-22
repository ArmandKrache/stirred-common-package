import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_common_domain/src/utils/resources/data_state.dart';

class HttpResponse<T> {
  final T data;
  final int statusCode;
  final Map<String, String> headers;

  HttpResponse({
    required this.data,
    required this.statusCode,
    required this.headers,
  });
}

class HttpClient {
  final http.Client _client;
  final String baseUrl;
  final Map<String, String> _headers;

  HttpClient({
    required this.baseUrl,
    http.Client? client,
    Map<String, String>? headers,
  })  : _client = client ?? http.Client(),
        _headers = headers ?? {};

  void setHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
  }

  void setHeader(String key, String value) {
    _headers[key] = value;
  }

  void removeHeader(String key) {
    _headers.remove(key);
  }

  Future<DataState<T>> get<T>(
    String path, {
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path).replace(
        queryParameters: queryParameters,
      );

      final response = await _client.get(
        uri,
        headers: _headers,
      );

      return _handleResponse<T>(response, fromJson);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<T>> post<T>(
    String path, {
    dynamic body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      final headers = {
        ..._headers,
        'Content-Type': 'application/json',
      };

      final response = await _client.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse<T>(response, fromJson);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<T>> postMultipart<T>(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, http.MultipartFile> files,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      final request = http.MultipartRequest('POST', uri);
      
      // Add headers
      request.headers.addAll(_headers);
      
      // Add fields
      fields.forEach((key, value) {
        if (value != null) {
          if (value is List || value is Map) {
            request.fields[key] = jsonEncode(value);
          } else {
            request.fields[key] = value.toString();
          }
        }
      });
      
      // Add files
      request.files.addAll(files.values);
      
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      return _handleResponse<T>(response, fromJson);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<T>> put<T>(
    String path, {
    dynamic body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      final headers = {
        ..._headers,
        'Content-Type': 'application/json',
      };

      final response = await _client.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse<T>(response, fromJson);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<T>> patch<T>(
    String path, {
    dynamic body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      final headers = {
        ..._headers,
        'Content-Type': 'application/json',
      };

      final response = await _client.patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse<T>(response, fromJson);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<T>> patchMultipart<T>(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, http.MultipartFile>? files,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      final request = http.MultipartRequest('PATCH', uri);
      
      // Add headers
      request.headers.addAll(_headers);
      
      // Add fields if provided
      if (fields != null) {
        fields.forEach((key, value) {
          if (value != null) {
            if (value is List || value is Map) {
              request.fields[key] = jsonEncode(value);
            } else {
              request.fields[key] = value.toString();
            }
          }
        });
      }
      
      // Add files if provided
      if (files != null) {
        request.files.addAll(files.values);
      }
      
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      return _handleResponse<T>(response, fromJson);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<void>> delete(
    String path,
  ) async {
    try {
      final uri = Uri.parse(baseUrl + path);

      final response = await _client.delete(
        uri,
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return const DataSuccess(null);
      } else {
        return DataFailed(Exception('Failed to delete: ${response.statusCode}'));
      }
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  DataState<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (fromJson == null) {
        return DataSuccess(null as T);
      }

      final body = jsonDecode(response.body);
      try {
        final data = fromJson(body);
        return DataSuccess(data);
      } catch (e) {
        return DataFailed(Exception('Failed to parse response: ${e.toString()}'));
      }
    } else {
      return DataFailed(Exception('Request failed: ${response.statusCode}'));
    }
  }

  void dispose() {
    _client.close();
  }
}

final httpClientProvider = Provider<HttpClient>((ref) {
  final client = HttpClient(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000'),
  );

  ref.onDispose(() {
    client.dispose();
  });

  return client;
}); 