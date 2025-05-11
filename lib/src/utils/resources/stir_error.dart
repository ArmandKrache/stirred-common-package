/// An error used to properly describe a failure that occured in the app.
class StirError {
  const StirError(
    this.statusCode, {
    this.message,
    this.reason,
  });

  /// The type of the error.
  final int statusCode;

  /// An optional message to describe the error.
  final String? message;

  /// An optional message to describe the reason of the error.
  final String? reason;

  @override
  String toString() {
    return 'Status Code : $statusCode | Message : $message | Reason : $reason';
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'reason': reason,
    };
  }

  static Future<StirError> fromJson(Map<String, dynamic> json) async {
    return StirError(
      json['statusCode'],
      message: json['message'],
      reason: json['reason'],
    );
  }
}
