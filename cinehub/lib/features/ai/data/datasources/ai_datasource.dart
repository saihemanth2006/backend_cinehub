import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/ai_models.dart';

/// AI data source — communicates with the CineHub AI orchestration backend.
/// Provides methods for all 10+ AI features.
class AiDataSource extends BaseApiService {
  AiDataSource(ApiClient client) : super(client);

  // ── Script Generation ─────────────────────────────────

  /// Generate a script using AI.
  Future<Either<Failure, ScriptDto>> generateScript(
    GenerateScriptRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.generateScript,
        data: request.toJson(),
      );
      return extractData(response, ScriptDto.fromJson);
    });
  }

  // ── Story Enhancement ─────────────────────────────────

  /// Analyze and enhance an existing script.
  Future<Either<Failure, StoryEnhancementDto>> enhanceStory(
    EnhanceStoryRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.enhanceStory,
        data: request.toJson(),
      );
      return extractData(response, StoryEnhancementDto.fromJson);
    });
  }

  // ── Genre Analysis ────────────────────────────────────

  /// Analyze genre classification of a story.
  Future<Either<Failure, GenreAnalysisDto>> analyzeGenre(
    AnalyzeGenreRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.analyzeGenre,
        data: request.toJson(),
      );
      return extractData(response, GenreAnalysisDto.fromJson);
    });
  }

  // ── Budget Estimation ─────────────────────────────────

  /// Estimate production budget using AI.
  Future<Either<Failure, BudgetEstimationDto>> estimateBudget(
    EstimateBudgetRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.estimateBudget,
        data: request.toJson(),
      );
      return extractData(response, BudgetEstimationDto.fromJson);
    });
  }

  // ── Talent Recommendation ─────────────────────────────

  /// Get AI-powered talent/team recommendations.
  Future<Either<Failure, TalentRecommendationDto>> recommendTalent(
    RecommendTalentRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.recommendTalent,
        data: request.toJson(),
      );
      return extractData(response, TalentRecommendationDto.fromJson);
    });
  }

  // ── Creative Assistant ────────────────────────────────

  /// Interactive AI creative assistant.
  Future<Either<Failure, CreativeAssistDto>> creativeAssist(
    CreativeAssistRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.creativeAssist,
        data: request.toJson(),
      );
      return extractData(response, CreativeAssistDto.fromJson);
    });
  }

  // ── Project Insights ──────────────────────────────────

  /// Generate AI-powered project insights.
  Future<Either<Failure, ProjectInsightsDto>> getProjectInsights(
    ProjectInsightsRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.projectInsights,
        data: request.toJson(),
      );
      return extractData(response, ProjectInsightsDto.fromJson);
    });
  }

  // ── Recommendations ───────────────────────────────────

  /// Get AI-powered recommendations for the current user.
  Future<Either<Failure, AiRecommendationDto>> getRecommendations() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiRecommendations);
      return extractData(response, AiRecommendationDto.fromJson);
    });
  }

  // ── Async Job Status ──────────────────────────────────

  /// Poll the status of an async AI job.
  Future<Either<Failure, AiJobStatusDto>> getJobStatus(String jobId) {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiJobStatus(jobId));
      return extractData(response, AiJobStatusDto.fromJson);
    });
  }

  // ── System Info ───────────────────────────────────────

  /// Get available AI providers.
  Future<Either<Failure, AiProviderInfoDto>> getProviders() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiProviders);
      return extractData(response, AiProviderInfoDto.fromJson);
    });
  }

  /// Get AI system dashboard data.
  Future<Either<Failure, AiDashboardDto>> getDashboard() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiDashboard);
      return extractData(response, AiDashboardDto.fromJson);
    });
  }

  /// Get current user's AI usage stats.
  Future<Either<Failure, AiUsageStatsDto>> getUsage() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.aiUsage);
      return extractData(response, AiUsageStatsDto.fromJson);
    });
  }
}

// ── Repository ──────────────────────────────────────────

class AiRepository {
  final AiDataSource _dataSource;

  AiRepository(this._dataSource);

  // Script
  Future<Either<Failure, ScriptDto>> generateScript(
    GenerateScriptRequest request,
  ) =>
      _dataSource.generateScript(request);

  // Enhancement
  Future<Either<Failure, StoryEnhancementDto>> enhanceStory(
    EnhanceStoryRequest request,
  ) =>
      _dataSource.enhanceStory(request);

  // Genre Analysis
  Future<Either<Failure, GenreAnalysisDto>> analyzeGenre(
    AnalyzeGenreRequest request,
  ) =>
      _dataSource.analyzeGenre(request);

  // Budget
  Future<Either<Failure, BudgetEstimationDto>> estimateBudget(
    EstimateBudgetRequest request,
  ) =>
      _dataSource.estimateBudget(request);

  // Talent
  Future<Either<Failure, TalentRecommendationDto>> recommendTalent(
    RecommendTalentRequest request,
  ) =>
      _dataSource.recommendTalent(request);

  // Creative Assistant
  Future<Either<Failure, CreativeAssistDto>> creativeAssist(
    CreativeAssistRequest request,
  ) =>
      _dataSource.creativeAssist(request);

  // Project Insights
  Future<Either<Failure, ProjectInsightsDto>> getProjectInsights(
    ProjectInsightsRequest request,
  ) =>
      _dataSource.getProjectInsights(request);

  // Recommendations
  Future<Either<Failure, AiRecommendationDto>> getRecommendations() =>
      _dataSource.getRecommendations();

  // Job Status
  Future<Either<Failure, AiJobStatusDto>> getJobStatus(String jobId) =>
      _dataSource.getJobStatus(jobId);

  // System
  Future<Either<Failure, AiProviderInfoDto>> getProviders() =>
      _dataSource.getProviders();

  Future<Either<Failure, AiDashboardDto>> getDashboard() =>
      _dataSource.getDashboard();

  Future<Either<Failure, AiUsageStatsDto>> getUsage() =>
      _dataSource.getUsage();
}

// ── Providers ───────────────────────────────────────────

final aiDataSourceProvider = Provider<AiDataSource>((ref) {
  return AiDataSource(ref.watch(apiClientProvider));
});

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepository(ref.watch(aiDataSourceProvider));
});
