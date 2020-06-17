import 'package:json_annotation/json_annotation.dart';

part 'RecipeSteps.g.dart';

@JsonSerializable()
class RecipeSteps {
  List<Step> steps;

  RecipeSteps({this.steps});

  factory RecipeSteps.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepsFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeStepsToJson(this);
}

@JsonSerializable()
class Step {
  int number;
  String step;

  Step({this.number, this.step});

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toJson() => _$StepToJson(this);
}
