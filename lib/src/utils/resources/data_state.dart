import 'package:http/http.dart' as http;

abstract class DataState<T> {
  final T? data;
  final Exception? exception;

  const DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Exception exception) : super(exception: exception);
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  NetworkException({
    required this.message,
    this.statusCode,
    this.body,
  });

  @override
  String toString() => 'NetworkException: $message (Status: $statusCode)';
}

extension HttpResponseExtension on http.Response {
  bool get isSuccessful => statusCode >= 200 && statusCode < 300;

  NetworkException toException() {
    return NetworkException(
      message: reasonPhrase ?? 'Unknown error',
      statusCode: statusCode,
      body: body,
    );
  }
}