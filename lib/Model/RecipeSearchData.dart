import 'package:json_annotation/json_annotation.dart';
import 'package:thereceipeapp/Model/RecipeSearchResult.dart';

part 'RecipeSearchData.g.dart';

@JsonSerializable()
class RecipeSearchData {
  List<RecipeSearchResult> results;
  int totalResults;

  RecipeSearchData({this.results, this.totalResults});

  factory RecipeSearchData.fromJson(Map<String, dynamic> json) =>
      _$RecipeSearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeSearchDataToJson(this);
}
