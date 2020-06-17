// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecipeSteps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSteps _$RecipeStepsFromJson(Map<String, dynamic> json) {
  return RecipeSteps(
    steps: (json['steps'] as List)
        ?.map(
            (e) => e == null ? null : Step.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecipeStepsToJson(RecipeSteps instance) =>
    <String, dynamic>{
      'steps': instance.steps,
    };

Step _$StepFromJson(Map<String, dynamic> json) {
  return Step(
    number: json['number'] as int,
    step: json['step'] as String,
  );
}

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'number': instance.number,
      'step': instance.step,
    };
