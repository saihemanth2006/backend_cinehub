// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIRequest _$AIRequestFromJson(Map<String, dynamic> json) => AIRequest(
  module: json['module'] as String,
  task: json['task'] as String,
  input: json['input'],
  options: json['options'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AIRequestToJson(AIRequest instance) => <String, dynamic>{
  'module': instance.module,
  'task': instance.task,
  'input': instance.input,
  'options': instance.options,
};
