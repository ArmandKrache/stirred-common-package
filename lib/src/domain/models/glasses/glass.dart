import 'package:freezed_annotation/freezed_annotation.dart';

part 'glass.freezed.dart';
part 'glass.g.dart';

@freezed
class Glass with _$Glass {
  const factory Glass({
    required String id,
    required String name,
    required String description,
    required String picture,
  }) = _Glass;

  factory Glass.fromJson(Map<String, dynamic> json) => _$GlassFromJson(json);
}