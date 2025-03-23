import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stirred_common_domain/src/utils/resources/tokens_management.dart';

class HttpBaseClient {
  final String baseUrl;
  final http.Client _client;

  HttpBaseClient({required this.baseUrl}) : _client = http.Client();

  Future<Map<String, String>> _prepareHeaders({
    Map<String, String> headers = const {},
    bool isJson = true,
  }) async {
    final result = Map<String, String>.from(headers);
    
    if (isJson) {
      result['Content-Type'] = 'application/json';
    }
    
    final token = await readAccessToken();
    if (token != null) {
      result['Authorization'] = 'JWT $token';
    }
    
    return result;
  }

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
      if (value != null) {
        if (value is List || value is Map) {
          request.fields[key] = jsonEncode(value);
        } else {
          request.fields[key] = value.toString();
        }
      }
    });

    request.files.addAll(files.values);
    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

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

  Future<http.Response> patchMultipart(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, http.MultipartFile>? files,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {}, isJson: false);
    
    final request = http.MultipartRequest('PATCH', uri)
      ..headers.addAll(finalHeaders);

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

    if (files != null) {
      request.files.addAll(files.values);
    }

    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + path);
    final finalHeaders = await _prepareHeaders(headers: headers ?? {});
    return _client.delete(uri, headers: finalHeaders);
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final headers = await _prepareHeaders(headers: request.headers);
    request.headers.addAll(headers);
    return _client.send(request);
  }

  void dispose() {
    _client.close();
  }
}
