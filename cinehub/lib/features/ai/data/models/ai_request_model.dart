///
/// @file ai_request_model.dart
/// @description AI Request data model — represents a unified AI generation request
///
library;

import 'package:json_annotation/json_annotation.dart';

part 'ai_request_model.g.dart';

/// Unified AI Request Model
/// 
/// Maps to the POST /ai/generate endpoint
/// 
/// Example:
/// ```dart
/// AIRequest(
///   module: 'script-development',
///   task: 'generate-script',
///   input: 'A detective solving cyber crimes in 2050',
///   options: {'provider': 'openai'},
/// )
/// ```
@JsonSerializable()
class AIRequest {
  /// AI module slug (script-development, trailer-concept, etc.)
  final String module;

  /// Task slug within module (generate-script, enhance-dialogue, etc.)
  final String task;

  /// Raw user input - can be string or structured object
  /// 
  /// Examples:
  /// - String: "A detective solving cyber crimes"
  /// - Object: {"premise": "...", "genre": "sci-fi"}
  final dynamic input;

  /// Optional generation parameters
  /// 
  /// Supported options:
  /// - provider: Override default AI provider (openai, gemini)
  /// - skipCache: Force bypass cache (default: false)
  /// - skipValidation: Skip output validation (default: false)
  /// - temperature: Generation temperature (0.0-1.0)
  /// - maxTokens: Maximum response tokens
  final Map<String, dynamic>? options;

  AIRequest({
    required this.module,
    required this.task,
    required this.input,
    this.options,
  });

  Map<String, dynamic> toJson() => _$AIRequestToJson(this);

  factory AIRequest.fromJson(Map<String, dynamic> json) =>
      _$AIRequestFromJson(json);

  @override
  String toString() => 'AIRequest(module: $module, task: $task)';
}
