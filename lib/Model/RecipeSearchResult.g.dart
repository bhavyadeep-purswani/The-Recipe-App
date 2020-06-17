// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecipeSearchResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSearchResult _$RecipeSearchResultFromJson(Map<String, dynamic> json) {
  return RecipeSearchResult(
    id: json['id'] as int,
    image: json['image'] as String,
    title: json['title'] as String,
    nutrition: (json['nutrition'] as List)
        ?.map((e) =>
            e == null ? null : Nutrition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    usedIngredients: (json['usedIngredients'] as List)
        ?.map((e) =>
            e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    missedIngredients: (json['missedIngredients'] as List)
        ?.map((e) =>
            e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sourceUrl: json['sourceUrl'] as String,
    analyzedInstructions: (json['analyzedInstructions'] as List)
        ?.map((e) =>
            e == null ? null : RecipeSteps.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    readyInMinutes: (json['readyInMinutes'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RecipeSearchResultToJson(RecipeSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'nutrition': instance.nutrition,
      'usedIngredients': instance.usedIngredients,
      'missedIngredients': instance.missedIngredients,
      'readyInMinutes': instance.readyInMinutes,
      'sourceUrl': instance.sourceUrl,
      'analyzedInstructions': instance.analyzedInstructions,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) {
  return Nutrition(
    title: json['title'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    unit: json['unit'] as String,
  );
}

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'title': instance.title,
      'amount': instance.amount,
      'unit': instance.unit,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    original: json['original'] as String,
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'original': instance.original,
    };
