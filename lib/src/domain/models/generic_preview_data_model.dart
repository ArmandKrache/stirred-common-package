import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_preview_data_model.freezed.dart';
part 'generic_preview_data_model.g.dart';

@freezed
class GenericPreviewDataModel with _$GenericPreviewDataModel {
  const factory GenericPreviewDataModel({
    required String id,
    required String name,
    @Default('') String description,
    String? picture,
  }) = _GenericPreviewDataModel;

  factory GenericPreviewDataModel.fromJson(Map<String, dynamic> json) =>
      _$GenericPreviewDataModelFromJson(json);
}