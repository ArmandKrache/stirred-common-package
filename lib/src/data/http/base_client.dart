import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stirred_common_domain/src/utils/resources/token_manager.dart';

/// Base HTTP client that handles basic HTTP operations and token management.
/// This class is responsible for making HTTP requests and managing authentication headers.
class BaseClient {
  final String baseUrl;
  final http.Client _client;
  final TokenManager _tokenManager;

  BaseClient({
    required this.baseUrl,
    required TokenManager tokenManager,
  }) : _client = http.Client(),
       _tokenManager = tokenManager;

  /// Prepares headers for HTTP requests, including authentication token.
  Future<Map<String, String>> _prepareHeaders({
    Map<String, String> headers = const {},
    bool isJson = true,
  }) async {
    final result = Map<String, String>.from(headers);
    
    result['Content-Type'] = isJson ? 'application/json' : 'multipart/form-data';
    
    final token = await _tokenManager.getAuthorizationHeader();
    if (token != null) {
      result['Authorization'] = token;
    }
    
    return result;
  }

  /// Makes a GET request to the specified endpoint.
  Future<http.Response> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path).replace(
      queryParameters: queryParameters,
    );
    final finalHeaders = await _prepareHeaders(headers: headers ?? {});
    return _client.get(uri, headers: finalHeaders);
  }

  /// Makes a POST request to the specified endpoint.
  Future<http.Response> post(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {});
    return _client.post(
      uri,
      headers: finalHeaders,
      body: body is String ? body : jsonEncode(body),
    );
  }

  /// Makes a multipart POST request to the specified endpoint.
  Future<http.Response> postMultipart(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, http.MultipartFile> files,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {}, isJson: false);
    
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(finalHeaders);

    fields.forEach((key, value) {
      request.fields[key] = value is String ? value : jsonEncode(value);
    });

    request.files.addAll(files.values);
    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

  /// Makes a PUT request to the specified endpoint.
  Future<http.Response> put(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {});
    return _client.put(
      uri,
      headers: finalHeaders,
      body: body is String ? body : jsonEncode(body),
    );
  }

  /// Makes a PATCH request to the specified endpoint.
  Future<http.Response> patch(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {});
    return _client.patch(
      uri,
      headers: finalHeaders,
      body: body is String ? body : jsonEncode(body),
    );
  }

  /// Makes a multipart PATCH request to the specified endpoint.
  Future<http.Response> patchMultipart(
    String path, {
    required Map<String, dynamic> fields,
    required Map<String, http.MultipartFile> files,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {}, isJson: false);
    
    final request = http.MultipartRequest('PATCH', uri)
      ..headers.addAll(finalHeaders);

    fields.forEach((key, value) {
      request.fields[key] = value is String ? value : jsonEncode(value);
    });

    request.files.addAll(files.values);
    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

  /// Makes a DELETE request to the specified endpoint.
  Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {});
    return _client.delete(uri, headers: finalHeaders);
  }

  /// Sends a raw HTTP request.
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final headers = await _prepareHeaders(headers: request.headers);
    request.headers.addAll(headers);
    return _client.send(request);
  }

  /// Closes the underlying HTTP client.
  void dispose() {
    _client.close();
  }
} 