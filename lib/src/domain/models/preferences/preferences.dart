import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stirred_common_domain/src/domain/models/generic_preview_data_model.dart';

part 'preferences.freezed.dart';
part 'preferences.g.dart';

@freezed
class Preferences with _$Preferences {
  const factory Preferences({
    @Default([]) List<GenericPreviewDataModel> favorites,
    @Default([]) List<GenericPreviewDataModel> likes,
    @Default([]) List<GenericPreviewDataModel> dislikes,
    @Default([]) List<GenericPreviewDataModel> allergies,
    @Default([]) List<String> diets,
  }) = _Preferences;

  factory Preferences.fromJson(Map<String, dynamic> json) => _$PreferencesFromJson(json);

}