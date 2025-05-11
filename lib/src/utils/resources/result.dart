import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/utils/resources/stir_error.dart';

part 'result.freezed.dart';

@freezed
class Result<S, F> with _$Result<S, F> {
  const factory Result.success(S success) = Success<S, F>;

  const factory Result.failure(F failure) = Failure<S, F>;
}

extension ResultExtensions<S, F> on Result<S, F> {
  Result<T, F> whenSuccess<T>(T Function(S) onSuccess) {
    return when(
      success: (s) => Result.success(onSuccess(s)),
      failure: Result.failure,
    );
  }

  Future<Result<T, F>> whenSuccessAsync<T>(Future<T> Function(S) onSuccess) {
    return when(
      success: (s) async => Result.success(await onSuccess(s)),
      failure: (f) async => Result.failure(f),
    );
  }

  Result<S, T> whenFailure<T>(T Function(F) onFailure) {
    return when(
      success: Result.success,
      failure: (f) => Result.failure(onFailure(f)),
    );
  }

  Result<S2, F2> remap<S2, F2>({
    required S2 Function(S) success,
    required F2 Function(F) failure,
  }) {
    return when(
      success: (s) => Result.success(success(s)),
      failure: (f) => Result.failure(failure(f)),
    );
  }

  Result<S2, F> remapSuccess<S2>({
    required S2 Function(S) success,
  }) {
    return when(
      success: (s) => Result.success(success(s)),
      failure: Result.failure,
    );
  }

  S successOr(S Function(F) onFailure) {
    return when(
      success: (s) => s,
      failure: (f) => onFailure(f),
    );
  }

  S? successOrNull() {
    return when(
      success: (s) => s,
      failure: (_) => null,
    );
  }

  String serialize() {
    return when(
      success: (s) => jsonEncode({'success': s}),
      failure: (f) => jsonEncode({'failure': f}),
    );
  }

  static Result<S, F> deserialize<S, F>(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    if (json.containsKey('success')) {
      return Result.success(json['success'] as S);
    } else if (json.containsKey('failure')) {
      return Result.failure(StirError.fromJson(json['failure'] as Map<String, dynamic>) as F);
    } else {
      throw UnsupportedError('Value $value is not supported');
    }
  }
}

extension ResultDecoder<F> on Result<Object?, F> {
  Result<S, F> decode<S>(S Function(Map<String, dynamic>) decoder) {
    return whenSuccess<S>((s) => decoder(s as Map<String, dynamic>));
  }

  Result<List<S>, F> decodeList<S>(S Function(Map<String, dynamic>) decoder) {
    return whenSuccess(
      (s) => (s as List<dynamic>).cast<Map<String, dynamic>>().map((json) => decoder(json)).toList(),
    );
  }
}

extension FutureResultDecoder<F> on Future<Result<Object?, F>> {
  Future<Result<S, F>> decode<S>(
    S Function(Map<String, dynamic>) decoder,
  ) async {
    return (await this).decode(decoder);
  }

  Future<Result<List<S>, F>> decodeList<S>(
    S Function(Map<String, dynamic>) decoder,
  ) async {
    return (await this).decodeList(decoder);
  }
}
