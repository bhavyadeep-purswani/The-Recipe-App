import 'package:json_annotation/json_annotation.dart';
import 'package:thereceipeapp/Model/RecipeSteps.dart';

part 'RecipeSearchResult.g.dart';

@JsonSerializable()
class RecipeSearchResult {
  int id;
  String image;
  String title;
  List<Nutrition> nutrition;
  List<Ingredient> usedIngredients;
  List<Ingredient> missedIngredients;
  double readyInMinutes;
  String sourceUrl;
  List<RecipeSteps> analyzedInstructions;

  RecipeSearchResult(
      {this.id,
      this.image,
      this.title,
      this.nutrition,
      this.usedIngredients,
      this.missedIngredients,
      this.sourceUrl,
      this.analyzedInstructions,
      this.readyInMinutes});

  Map<String, String> getInstructionList() {
    Map<String, String> map = {};
    analyzedInstructions.forEach((value) =>
        value.steps.forEach((step) => map[step.number.toString()] = step.step));
    return map;
  }

  Map<String, String> getNutritionInfo() {
    Map<String, String> map = {};
    if (nutrition != null) {
      nutrition.forEach((value) =>
          map["${value.title} (${value.unit})"] = value.amount.toString());
    }
    return map;
  }

  factory RecipeSearchResult.fromJson(Map<String, dynamic> json) =>
      _$RecipeSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeSearchResultToJson(this);
}

@JsonSerializable()
class Nutrition {
  String title;
  double amount;
  String unit;

  Nutrition({this.title, this.amount, this.unit});

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}

@JsonSerializable()
class Ingredient {
  String original;

  Ingredient({this.original});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
