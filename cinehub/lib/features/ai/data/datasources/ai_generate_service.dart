import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

// ═══════════════════════════════════════════════════════════
// ═  UNIFIED AI GENERATION SERVICE
// ═══════════════════════════════════════════════════════════

/// Centralized AI service layer.
///
/// Communicates with the unified POST /ai/generate endpoint.
/// All AI features flow through [generate] — no separate methods needed.
class AiGenerateService extends BaseApiService {
  AiGenerateService(ApiClient client) : super(client);

  /// The ONE method for all AI features.
  ///
  /// ```dart
  /// final result = await service.generate(
  ///   module: 'script-development',
  ///   task: 'story-expansion',
  ///   input: 'A detective solving cyber crimes in 2050',
  ///   options: {'genre': 'sci-fi', 'tone': 'dark'},
  /// );
  /// ```
  Future<Either<Failure, AiGenerateResponse>> generate({
    required String module,
    required String task,
    required dynamic input,
    Map<String, dynamic> options = const {},
  }) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.aiGenerate,
        data: {
          'module': module,
          'task': task,
          'input': input,
          'options': options,
        },
      );
      return extractData(response, AiGenerateResponse.fromJson);
    });
  }

  /// Fetches all available modules and their tasks.
  Future<Either<Failure, List<AiModuleInfo>>> getCapabilities() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiCapabilities);
      final data = response.data['data'] as List;
      return data.map((e) => AiModuleInfo.fromJson(e)).toList();
    });
  }

  /// Fetches available modules list.
  Future<Either<Failure, List<String>>> getModules() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiModules);
      final data = response.data['data'] as List;
      return data.map((e) => e.toString()).toList();
    });
  }

  /// Fetches tasks for a specific module.
  Future<Either<Failure, List<AiTaskInfo>>> getModuleTasks(String module) {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiModuleTasks(module));
      final data = response.data['data'] as List;
      return data.map((e) => AiTaskInfo.fromJson(e)).toList();
    });
  }
}

// ═══════════════════════════════════════════════════════════
// ═  RESPONSE MODELS
// ═══════════════════════════════════════════════════════════

/// Unified AI generation response envelope.
class AiGenerateResponse {
  final bool success;
  final String module;
  final String task;
  final Map<String, dynamic> data;
  final AiGenerateMeta? meta;

  const AiGenerateResponse({
    required this.success,
    required this.module,
    required this.task,
    required this.data,
    this.meta,
  });

  factory AiGenerateResponse.fromJson(Map<String, dynamic> json) {
    // Handle nested data envelope from ApiResponse
    final innerData = json['data'] ?? json;
    return AiGenerateResponse(
      success: innerData['success'] ?? true,
      module: innerData['module'] ?? '',
      task: innerData['task'] ?? '',
      data: Map<String, dynamic>.from(innerData['data'] ?? {}),
      meta: innerData['meta'] != null
          ? AiGenerateMeta.fromJson(innerData['meta'])
          : null,
    );
  }

  /// Helper to get a typed value from data.
  T? getValue<T>(String key) {
    final val = data[key];
    return val is T ? val : null;
  }

  /// Get a list from data.
  List<dynamic> getList(String key) {
    final val = data[key];
    return val is List ? val : [];
  }

  /// Get a nested map from data.
  Map<String, dynamic> getMap(String key) {
    final val = data[key];
    return val is Map<String, dynamic> ? val : {};
  }
}

/// Meta information about the AI generation.
class AiGenerateMeta {
  final String? templateId;
  final String? provider;
  final String? model;
  final int? tokensUsed;
  final int? generationTimeMs;
  final int? executionTimeMs;
  final bool cached;
  final String? workflowName;
  final List<String>? warnings;

  const AiGenerateMeta({
    this.templateId,
    this.provider,
    this.model,
    this.tokensUsed,
    this.generationTimeMs,
    this.executionTimeMs,
    this.cached = false,
    this.workflowName,
    this.warnings,
  });

  factory AiGenerateMeta.fromJson(Map<String, dynamic> json) {
    return AiGenerateMeta(
      templateId: json['templateId'],
      provider: json['provider'],
      model: json['model'],
      tokensUsed: json['tokensUsed'],
      generationTimeMs: json['generationTimeMs'],
      executionTimeMs: json['executionTimeMs'],
      cached: json['cached'] ?? false,
      workflowName: json['workflowName'],
      warnings: json['warnings'] != null
          ? List<String>.from(json['warnings'])
          : null,
    );
  }
}

/// Module capabilities information.
class AiModuleInfo {
  final String module;
  final List<AiTaskInfo> tasks;

  const AiModuleInfo({required this.module, required this.tasks});

  factory AiModuleInfo.fromJson(Map<String, dynamic> json) {
    return AiModuleInfo(
      module: json['module'] ?? '',
      tasks: (json['tasks'] as List?)
              ?.map((e) => AiTaskInfo.fromJson(e))
              .toList() ??
          [],
    );
  }
}

/// Task information within a module.
class AiTaskInfo {
  final String task;
  final String name;
  final String description;

  const AiTaskInfo({
    required this.task,
    required this.name,
    required this.description,
  });

  factory AiTaskInfo.fromJson(Map<String, dynamic> json) {
    return AiTaskInfo(
      task: json['task'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ═  MODULE CONSTANTS
// ═══════════════════════════════════════════════════════════

/// All available AI modules and their tasks.
/// Use these constants to avoid typos when calling [AiGenerateService.generate].
abstract class AiModules {
  // ── Script Development ──────────────────────────────────
  static const scriptDevelopment = 'script-development';
  static const storyExpansion = 'story-expansion';
  static const generateScreenplay = 'generate-screenplay';
  static const dialogueEnhancement = 'dialogue-enhancement';
  static const characterDevelopment = 'character-development';
  static const genreAnalysis = 'genre-analysis';
  static const sceneBreakdown = 'scene-breakdown';

  // ── Trailer Concept ─────────────────────────────────────
  static const trailerConcept = 'trailer-concept';
  static const trailerNarration = 'trailer-narration';
  static const trailerSequencing = 'trailer-sequencing';
  static const hookGeneration = 'hook-generation';
  static const trailerStructure = 'trailer-structure';
  static const musicMood = 'music-mood';

  // ── Video Enhancement ───────────────────────────────────
  static const videoEnhancement = 'video-enhancement';
  static const editingSuggestions = 'editing-suggestions';
  static const colorGrading = 'color-grading';
  static const subtitleGeneration = 'subtitle-generation';
  static const pacingAnalysis = 'pacing-analysis';
  static const cinematicEnhancement = 'cinematic-enhancement';

  // ── Cast & Crew ─────────────────────────────────────────
  static const castCrew = 'cast-crew';
  static const crewRecommendations = 'crew-recommendations';
  static const talentMatching = 'talent-matching';
  static const skillAnalysis = 'skill-analysis';
  static const teamComposition = 'team-composition';

  // ── Production Intelligence ─────────────────────────────
  static const productionIntelligence = 'production-intelligence';
  static const budgetEstimation = 'budget-estimation';
  static const shootingSchedule = 'shooting-schedule';
  static const equipmentSuggestions = 'equipment-suggestions';
  static const complexityAnalysis = 'complexity-analysis';

  // ── Distribution & Promotion ────────────────────────────
  static const distributionPromotion = 'distribution-promotion';
  static const festivalRecommendations = 'festival-recommendations';
  static const audienceTargeting = 'audience-targeting';
  static const socialMediaCaptions = 'social-media-captions';
  static const promotionStrategy = 'promotion-strategy';
  static const copywriting = 'copywriting';

  // ── Pre-Visualization ───────────────────────────────────
  static const preVisualization = 'pre-visualization';
  static const shotSuggestions = 'shot-suggestions';
  static const cameraAngles = 'camera-angles';
  static const moodboardPrompts = 'moodboard-prompts';
  static const lightingSuggestions = 'lighting-suggestions';
  static const visualStorytelling = 'visual-storytelling';
}

// ═══════════════════════════════════════════════════════════
// ═  PROVIDERS
// ═══════════════════════════════════════════════════════════

final aiGenerateServiceProvider = Provider<AiGenerateService>((ref) {
  return AiGenerateService(ref.watch(apiClientProvider));
});
