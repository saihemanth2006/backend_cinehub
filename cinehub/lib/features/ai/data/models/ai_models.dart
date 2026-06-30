import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_models.freezed.dart';
part 'ai_models.g.dart';

// ── Request Models ──────────────────────────────────────

@freezed
class GenerateScriptRequest with _$GenerateScriptRequest {
  const factory GenerateScriptRequest({
    required String projectId,
    required String format,
    required String prompt,
    String? genre,
    String? tone,
    @Default('medium') String length,
    List<ScriptCharacterInput>? characters,
    String? additionalContext,
    String? provider,
  }) = _GenerateScriptRequest;

  factory GenerateScriptRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateScriptRequestFromJson(json);
}

@freezed
class ScriptCharacterInput with _$ScriptCharacterInput {
  const factory ScriptCharacterInput({
    required String name,
    String? description,
  }) = _ScriptCharacterInput;

  factory ScriptCharacterInput.fromJson(Map<String, dynamic> json) =>
      _$ScriptCharacterInputFromJson(json);
}

@freezed
class EnhanceStoryRequest with _$EnhanceStoryRequest {
  const factory EnhanceStoryRequest({
    required String content,
    String? logline,
    String? genre,
    List<String>? focusAreas,
    String? provider,
  }) = _EnhanceStoryRequest;

  factory EnhanceStoryRequest.fromJson(Map<String, dynamic> json) =>
      _$EnhanceStoryRequestFromJson(json);
}

@freezed
class AnalyzeGenreRequest with _$AnalyzeGenreRequest {
  const factory AnalyzeGenreRequest({
    required String logline,
    String? synopsis,
    String? content,
    String? provider,
  }) = _AnalyzeGenreRequest;

  factory AnalyzeGenreRequest.fromJson(Map<String, dynamic> json) =>
      _$AnalyzeGenreRequestFromJson(json);
}

@freezed
class EstimateBudgetRequest with _$EstimateBudgetRequest {
  const factory EstimateBudgetRequest({
    required String projectType,
    String? location,
    String? duration,
    int? scenes,
    int? characters,
    String? content,
    String? provider,
  }) = _EstimateBudgetRequest;

  factory EstimateBudgetRequest.fromJson(Map<String, dynamic> json) =>
      _$EstimateBudgetRequestFromJson(json);
}

@freezed
class RecommendTalentRequest with _$RecommendTalentRequest {
  const factory RecommendTalentRequest({
    required String projectType,
    String? genre,
    String? budget,
    @Default('independent') String scale,
    String? requirements,
    String? provider,
  }) = _RecommendTalentRequest;

  factory RecommendTalentRequest.fromJson(Map<String, dynamic> json) =>
      _$RecommendTalentRequestFromJson(json);
}

@freezed
class CreativeAssistRequest with _$CreativeAssistRequest {
  const factory CreativeAssistRequest({
    required String query,
    String? projectContext,
    String? context,
    String? provider,
  }) = _CreativeAssistRequest;

  factory CreativeAssistRequest.fromJson(Map<String, dynamic> json) =>
      _$CreativeAssistRequestFromJson(json);
}

@freezed
class ProjectInsightsRequest with _$ProjectInsightsRequest {
  const factory ProjectInsightsRequest({
    required String projectId,
    String? provider,
  }) = _ProjectInsightsRequest;

  factory ProjectInsightsRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectInsightsRequestFromJson(json);
}

// ── Response Models ─────────────────────────────────────

@freezed
class ScriptDto with _$ScriptDto {
  const factory ScriptDto({
    required String id,
    required String title,
    required String format,
    String? status,
    String? content,
    String? logline,
    String? synopsis,
    bool? aiGenerated,
    AiMetadataDto? aiMetadata,
    int? version,
    int? wordCount,
    int? pageCount,
    int? estimatedDuration,
    String? project,
    String? author,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ScriptDto;

  factory ScriptDto.fromJson(Map<String, dynamic> json) =>
      _$ScriptDtoFromJson(json);
}

@freezed
class AiMetadataDto with _$AiMetadataDto {
  const factory AiMetadataDto({
    String? provider,
    String? model,
    int? tokensUsed,
    int? generationTimeMs,
    DateTime? generatedAt,
  }) = _AiMetadataDto;

  factory AiMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$AiMetadataDtoFromJson(json);
}

/// Envelope for all AI responses from the orchestrator
@freezed
class AiResponseEnvelope<T> with _$AiResponseEnvelope<T> {
  const factory AiResponseEnvelope({
    required T data,
    required AiResponseMeta meta,
  }) = _AiResponseEnvelope<T>;
}

@freezed
class AiResponseMeta with _$AiResponseMeta {
  const factory AiResponseMeta({
    String? templateId,
    String? provider,
    String? model,
    int? tokensUsed,
    int? generationTimeMs,
    @Default(false) bool cached,
    List<String>? warnings,
  }) = _AiResponseMeta;

  factory AiResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$AiResponseMetaFromJson(json);
}

// ── Story Enhancement Response ──────────────────────────

@freezed
class StoryEnhancementDto with _$StoryEnhancementDto {
  const factory StoryEnhancementDto({
    int? overallScore,
    List<String>? strengths,
    List<String>? weaknesses,
    List<EnhancementSuggestionDto>? suggestions,
    String? enhancedLogline,
    Map<String, dynamic>? paceAnalysis,
    List<CharacterNoteDto>? characterNotes,
  }) = _StoryEnhancementDto;

  factory StoryEnhancementDto.fromJson(Map<String, dynamic> json) =>
      _$StoryEnhancementDtoFromJson(json);
}

@freezed
class EnhancementSuggestionDto with _$EnhancementSuggestionDto {
  const factory EnhancementSuggestionDto({
    String? area,
    String? severity,
    String? description,
    List<int>? affectedScenes,
    String? example,
  }) = _EnhancementSuggestionDto;

  factory EnhancementSuggestionDto.fromJson(Map<String, dynamic> json) =>
      _$EnhancementSuggestionDtoFromJson(json);
}

@freezed
class CharacterNoteDto with _$CharacterNoteDto {
  const factory CharacterNoteDto({
    String? character,
    String? note,
  }) = _CharacterNoteDto;

  factory CharacterNoteDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterNoteFromJson(json);
}

// ── Genre Analysis Response ─────────────────────────────

@freezed
class GenreAnalysisDto with _$GenreAnalysisDto {
  const factory GenreAnalysisDto({
    String? primaryGenre,
    List<String>? subGenres,
    double? genreConfidence,
    List<GenreElementDto>? genreElements,
    List<ComparableFilmDto>? comparableFilms,
    Map<String, dynamic>? audienceProfile,
    Map<String, dynamic>? marketViability,
    Map<String, dynamic>? toneAnalysis,
  }) = _GenreAnalysisDto;

  factory GenreAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$GenreAnalysisDtoFromJson(json);
}

@freezed
class GenreElementDto with _$GenreElementDto {
  const factory GenreElementDto({
    String? element,
    bool? present,
    String? strength,
  }) = _GenreElementDto;

  factory GenreElementDto.fromJson(Map<String, dynamic> json) =>
      _$GenreElementDtoFromJson(json);
}

@freezed
class ComparableFilmDto with _$ComparableFilmDto {
  const factory ComparableFilmDto({
    String? title,
    int? year,
    double? similarity,
    String? reason,
  }) = _ComparableFilmDto;

  factory ComparableFilmDto.fromJson(Map<String, dynamic> json) =>
      _$ComparableFilmDtoFromJson(json);
}

// ── Budget Estimation Response ──────────────────────────

@freezed
class BudgetEstimationDto with _$BudgetEstimationDto {
  const factory BudgetEstimationDto({
    BudgetTotalDto? totalEstimate,
    List<BudgetItemDto>? breakdown,
    List<String>? assumptions,
    List<String>? costDrivers,
    List<String>? savingOpportunities,
    Map<String, dynamic>? productionSchedule,
    List<BudgetRiskDto>? riskFactors,
  }) = _BudgetEstimationDto;

  factory BudgetEstimationDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetEstimationDtoFromJson(json);
}

@freezed
class BudgetTotalDto with _$BudgetTotalDto {
  const factory BudgetTotalDto({
    double? low,
    double? mid,
    double? high,
    @Default('USD') String currency,
  }) = _BudgetTotalDto;

  factory BudgetTotalDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetTotalDtoFromJson(json);
}

@freezed
class BudgetItemDto with _$BudgetItemDto {
  const factory BudgetItemDto({
    String? category,
    String? description,
    double? low,
    double? mid,
    double? high,
    double? percentage,
    String? notes,
  }) = _BudgetItemDto;

  factory BudgetItemDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetItemDtoFromJson(json);
}

@freezed
class BudgetRiskDto with _$BudgetRiskDto {
  const factory BudgetRiskDto({
    String? factor,
    String? impact,
  }) = _BudgetRiskDto;

  factory BudgetRiskDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetRiskDtoFromJson(json);
}

// ── Talent Recommendation Response ──────────────────────

@freezed
class TalentRecommendationDto with _$TalentRecommendationDto {
  const factory TalentRecommendationDto({
    List<TalentRoleDto>? roles,
    Map<String, dynamic>? teamSize,
    List<Map<String, dynamic>>? departmentBreakdown,
    String? hiringTimeline,
    String? budgetConsiderations,
  }) = _TalentRecommendationDto;

  factory TalentRecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$TalentRecommendationDtoFromJson(json);
}

@freezed
class TalentRoleDto with _$TalentRoleDto {
  const factory TalentRoleDto({
    String? title,
    String? department,
    String? priority,
    String? description,
    List<String>? skillsRequired,
    String? experienceLevel,
    Map<String, dynamic>? estimatedRate,
    String? notes,
  }) = _TalentRoleDto;

  factory TalentRoleDto.fromJson(Map<String, dynamic> json) =>
      _$TalentRoleDtoFromJson(json);
}

// ── Creative Assistant Response ─────────────────────────

@freezed
class CreativeAssistDto with _$CreativeAssistDto {
  const factory CreativeAssistDto({
    String? response,
    List<String>? suggestions,
    List<CreativeReferenceDto>? references,
    List<String>? nextSteps,
    List<String>? relatedTopics,
  }) = _CreativeAssistDto;

  factory CreativeAssistDto.fromJson(Map<String, dynamic> json) =>
      _$CreativeAssistDtoFromJson(json);
}

@freezed
class CreativeReferenceDto with _$CreativeReferenceDto {
  const factory CreativeReferenceDto({
    String? title,
    String? relevance,
  }) = _CreativeReferenceDto;

  factory CreativeReferenceDto.fromJson(Map<String, dynamic> json) =>
      _$CreativeReferenceDtoFromJson(json);
}

// ── Project Insights Response ───────────────────────────

@freezed
class ProjectInsightsDto with _$ProjectInsightsDto {
  const factory ProjectInsightsDto({
    ProjectHealthDto? projectHealth,
    List<ProjectInsightItemDto>? insights,
    Map<String, dynamic>? predictions,
    Map<String, dynamic>? benchmarks,
  }) = _ProjectInsightsDto;

  factory ProjectInsightsDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectInsightsDtoFromJson(json);
}

@freezed
class ProjectHealthDto with _$ProjectHealthDto {
  const factory ProjectHealthDto({
    int? score,
    String? status,
  }) = _ProjectHealthDto;

  factory ProjectHealthDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectHealthDtoFromJson(json);
}

@freezed
class ProjectInsightItemDto with _$ProjectInsightItemDto {
  const factory ProjectInsightItemDto({
    String? type,
    String? priority,
    String? title,
    String? description,
    bool? actionRequired,
    String? suggestedAction,
  }) = _ProjectInsightItemDto;

  factory ProjectInsightItemDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectInsightItemDtoFromJson(json);
}

// ── Recommendation Response ─────────────────────────────

@freezed
class AiRecommendationDto with _$AiRecommendationDto {
  const factory AiRecommendationDto({
    List<dynamic>? suggestedCreators,
    List<dynamic>? suggestedProjects,
    List<dynamic>? suggestedSkills,
  }) = _AiRecommendationDto;

  factory AiRecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$AiRecommendationDtoFromJson(json);
}

// ── AI Job Status ───────────────────────────────────────

@freezed
class AiJobStatusDto with _$AiJobStatusDto {
  const factory AiJobStatusDto({
    String? jobId,
    String? status,
    String? templateId,
    double? progress,
    int? attemptsMade,
    Map<String, dynamic>? result,
    String? error,
    DateTime? createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
  }) = _AiJobStatusDto;

  factory AiJobStatusDto.fromJson(Map<String, dynamic> json) =>
      _$AiJobStatusDtoFromJson(json);
}

// ── AI Dashboard ────────────────────────────────────────

@freezed
class AiDashboardDto with _$AiDashboardDto {
  const factory AiDashboardDto({
    AiDashboardOverviewDto? overview,
    Map<String, dynamic>? providers,
    Map<String, dynamic>? templates,
    List<Map<String, dynamic>>? recentErrors,
  }) = _AiDashboardDto;

  factory AiDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$AiDashboardDtoFromJson(json);
}

@freezed
class AiDashboardOverviewDto with _$AiDashboardOverviewDto {
  const factory AiDashboardOverviewDto({
    int? totalRequests,
    int? totalTokens,
    String? totalCost,
    String? averageLatency,
    String? errorRate,
    String? cacheHitRate,
  }) = _AiDashboardOverviewDto;

  factory AiDashboardOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$AiDashboardOverviewDtoFromJson(json);
}

// ── AI Usage Stats ──────────────────────────────────────

@freezed
class AiUsageStatsDto with _$AiUsageStatsDto {
  const factory AiUsageStatsDto({
    @Default(0) int requests,
    @Default(0) int tokens,
    @Default(0) double cost,
  }) = _AiUsageStatsDto;

  factory AiUsageStatsDto.fromJson(Map<String, dynamic> json) =>
      _$AiUsageStatsDtoFromJson(json);
}

// ── AI Provider Info ────────────────────────────────────

@freezed
class AiProviderInfoDto with _$AiProviderInfoDto {
  const factory AiProviderInfoDto({
    List<String>? providers,
    Map<String, dynamic>? health,
  }) = _AiProviderInfoDto;

  factory AiProviderInfoDto.fromJson(Map<String, dynamic> json) =>
      _$AiProviderInfoDtoFromJson(json);
}
