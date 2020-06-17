// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecipeSearchData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSearchData _$RecipeSearchDataFromJson(Map<String, dynamic> json) {
  return RecipeSearchData(
    results: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : RecipeSearchResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalResults: json['totalResults'] as int,
  );
}

Map<String, dynamic> _$RecipeSearchDataToJson(RecipeSearchData instance) =>
    <String, dynamic>{
      'results': instance.results,
      'totalResults': instance.totalResults,
    };
