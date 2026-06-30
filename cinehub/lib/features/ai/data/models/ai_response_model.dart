///
/// @file ai_response_model.dart
/// @description AI Response data model — represents the structured AI generation response
///
library;

import 'package:json_annotation/json_annotation.dart';

part 'ai_response_model.g.dart';

/// Unified AI Response Model
/// 
/// Response from POST /ai/generate endpoint
/// 
/// Example:
/// ```dart
/// AIResponse(
///   success: true,
///   module: 'script-development',
///   task: 'generate-script',
///   data: {...},
///   meta: AIResponseMeta(...),
/// )
/// ```
@JsonSerializable()
class AIResponse {
  /// Whether the generation was successful
  final bool success;

  /// Module that processed the request
  final String module;

  /// Task that was executed
  final String task;

  /// Generated data - module/task specific
  /// 
  /// Type and structure depends on module:
  /// - script-development → screenplay, story outline, etc.
  /// - trailer-concept → narration, sequence, hooks
  /// - video-enhancement → editing suggestions, color grading
  /// - etc.
  final dynamic data;

  /// Response metadata
  final AIResponseMeta meta;

  /// Optional error message
  final String? error;

  AIResponse({
    required this.success,
    required this.module,
    required this.task,
    required this.data,
    required this.meta,
    this.error,
  });

  Map<String, dynamic> toJson() => _$AIResponseToJson(this);

  factory AIResponse.fromJson(Map<String, dynamic> json) =>
      _$AIResponseFromJson(json);

  /// Convenience getter for checking if response contains error
  bool get hasError => error != null && error!.isNotEmpty;

  /// Convenience getter for module::task combined key
  String get workflowKey => '$module::$task';

  @override
  String toString() => 'AIResponse(success: $success, module: $module, task: $task)';
}

/// Response Metadata
@JsonSerializable()
class AIResponseMeta {
  /// AI provider used (openai, gemini)
  final String provider;

  /// Model used (gpt-4, gemini-pro, etc.)
  final String? model;

  /// Total tokens used in generation
  final int? tokensUsed;

  /// Execution time in milliseconds
  final int? executionTimeMs;

  /// Whether response was retrieved from cache
  final bool cached;

  /// Request ID for tracing
  final String? requestId;

  /// When the response was generated
  @JsonKey(fromJson: _parseDateTime, toJson: _formatDateTime)
  final DateTime? generatedAt;

  AIResponseMeta({
    required this.provider,
    this.model,
    this.tokensUsed,
    this.executionTimeMs,
    this.cached = false,
    this.requestId,
    this.generatedAt,
  });

  Map<String, dynamic> toJson() => _$AIResponseMetaToJson(this);

  factory AIResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$AIResponseMetaFromJson(json);

  @override
  String toString() => 'AIResponseMeta(provider: $provider, model: $model)';
}

// DateTime serialization helpers
DateTime? _parseDateTime(dynamic value) {
  if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}

String _formatDateTime(DateTime? value) {
  return value?.toIso8601String() ?? '';
}

/// Module-specific response wrappers for type safety

/// Script Development response wrapper
@JsonSerializable()
class ScriptDevelopmentResponse {
  final String? title;
  final String? logline;
  final String? synopsis;
  final String? content;
  final List<dynamic>? characters;
  final List<dynamic>? scenes;
  final List<dynamic>? themes;
  final int? estimatedRuntime;

  ScriptDevelopmentResponse({
    this.title,
    this.logline,
    this.synopsis,
    this.content,
    this.characters,
    this.scenes,
    this.themes,
    this.estimatedRuntime,
  });

  factory ScriptDevelopmentResponse.fromJson(Map<String, dynamic> json) =>
      _$ScriptDevelopmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptDevelopmentResponseToJson(this);
}

/// Trailer Concept response wrapper
@JsonSerializable()
class TrailerConceptResponse {
  final String? narration;
  final List<dynamic>? beats;
  final List<dynamic>? hooks;
  final String? structure;
  final List<dynamic>? musicMood;
  final String? totalDuration;

  TrailerConceptResponse({
    this.narration,
    this.beats,
    this.hooks,
    this.structure,
    this.musicMood,
    this.totalDuration,
  });

  factory TrailerConceptResponse.fromJson(Map<String, dynamic> json) =>
      _$TrailerConceptResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerConceptResponseToJson(this);
}

/// Video Enhancement response wrapper
@JsonSerializable()
class VideoEnhancementResponse {
  final List<dynamic>? suggestions;
  final Map<String, dynamic>? colorPalette;
  final List<dynamic>? subtitles;
  final Map<String, dynamic>? pacing;
  final List<dynamic>? effects;

  VideoEnhancementResponse({
    this.suggestions,
    this.colorPalette,
    this.subtitles,
    this.pacing,
    this.effects,
  });

  factory VideoEnhancementResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoEnhancementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoEnhancementResponseToJson(this);
}

/// Cast & Crew response wrapper
@JsonSerializable()
class CastCrewResponse {
  final List<dynamic>? roles;
  final List<dynamic>? talents;
  final Map<String, dynamic>? teamComposition;
  final List<dynamic>? skills;

  CastCrewResponse({
    this.roles,
    this.talents,
    this.teamComposition,
    this.skills,
  });

  factory CastCrewResponse.fromJson(Map<String, dynamic> json) =>
      _$CastCrewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CastCrewResponseToJson(this);
}

/// Production Intelligence response wrapper
@JsonSerializable()
class ProductionIntelligenceResponse {
  final Map<String, dynamic>? budget;
  final Map<String, dynamic>? schedule;
  final List<dynamic>? equipment;
  final Map<String, dynamic>? complexity;

  ProductionIntelligenceResponse({
    this.budget,
    this.schedule,
    this.equipment,
    this.complexity,
  });

  factory ProductionIntelligenceResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductionIntelligenceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionIntelligenceResponseToJson(this);
}

/// Distribution & Promotion response wrapper
@JsonSerializable()
class DistributionPromotionResponse {
  final List<dynamic>? festivals;
  final Map<String, dynamic>? audience;
  final List<dynamic>? captions;
  final Map<String, dynamic>? strategy;
  final String? copywriting;

  DistributionPromotionResponse({
    this.festivals,
    this.audience,
    this.captions,
    this.strategy,
    this.copywriting,
  });

  factory DistributionPromotionResponse.fromJson(Map<String, dynamic> json) =>
      _$DistributionPromotionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionPromotionResponseToJson(this);
}

/// Pre-Visualization response wrapper
@JsonSerializable()
class PreVisualizationResponse {
  final List<dynamic>? shots;
  final List<dynamic>? cameraAngles;
  final List<dynamic>? moodboardPrompts;
  final Map<String, dynamic>? lighting;
  final Map<String, dynamic>? visualStorytelling;

  PreVisualizationResponse({
    this.shots,
    this.cameraAngles,
    this.moodboardPrompts,
    this.lighting,
    this.visualStorytelling,
  });

  factory PreVisualizationResponse.fromJson(Map<String, dynamic> json) =>
      _$PreVisualizationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreVisualizationResponseToJson(this);
}
