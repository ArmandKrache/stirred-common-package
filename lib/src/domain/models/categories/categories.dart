import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories.freezed.dart';
part 'categories.g.dart';

@freezed
class Categories with _$Categories {
  const factory Categories({
    @Default([]) List<String> origins,
    @Default([]) List<String> strengths,
    @Default([]) List<String> eras,
    @Default([]) List<String> diets,
    @Default([]) List<String> seasons,
    @Default([]) List<String> colors,
    @Default([]) List<String> keywords,
  }) = _Categories;

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);
}