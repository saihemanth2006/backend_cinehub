// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerateScriptRequest _$GenerateScriptRequestFromJson(
  Map<String, dynamic> json,
) => _GenerateScriptRequest(
  projectId: json['projectId'] as String,
  format: json['format'] as String,
  prompt: json['prompt'] as String,
  genre: json['genre'] as String?,
  tone: json['tone'] as String?,
  length: json['length'] as String? ?? 'medium',
  characters: (json['characters'] as List<dynamic>?)
      ?.map((e) => ScriptCharacterInput.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalContext: json['additionalContext'] as String?,
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$GenerateScriptRequestToJson(
  _GenerateScriptRequest instance,
) => <String, dynamic>{
  'projectId': instance.projectId,
  'format': instance.format,
  'prompt': instance.prompt,
  'genre': instance.genre,
  'tone': instance.tone,
  'length': instance.length,
  'characters': instance.characters,
  'additionalContext': instance.additionalContext,
  'provider': instance.provider,
};

_ScriptCharacterInput _$ScriptCharacterInputFromJson(
  Map<String, dynamic> json,
) => _ScriptCharacterInput(
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ScriptCharacterInputToJson(
  _ScriptCharacterInput instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};

_EnhanceStoryRequest _$EnhanceStoryRequestFromJson(Map<String, dynamic> json) =>
    _EnhanceStoryRequest(
      content: json['content'] as String,
      logline: json['logline'] as String?,
      genre: json['genre'] as String?,
      focusAreas: (json['focusAreas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$EnhanceStoryRequestToJson(
  _EnhanceStoryRequest instance,
) => <String, dynamic>{
  'content': instance.content,
  'logline': instance.logline,
  'genre': instance.genre,
  'focusAreas': instance.focusAreas,
  'provider': instance.provider,
};

_AnalyzeGenreRequest _$AnalyzeGenreRequestFromJson(Map<String, dynamic> json) =>
    _AnalyzeGenreRequest(
      logline: json['logline'] as String,
      synopsis: json['synopsis'] as String?,
      content: json['content'] as String?,
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$AnalyzeGenreRequestToJson(
  _AnalyzeGenreRequest instance,
) => <String, dynamic>{
  'logline': instance.logline,
  'synopsis': instance.synopsis,
  'content': instance.content,
  'provider': instance.provider,
};

_EstimateBudgetRequest _$EstimateBudgetRequestFromJson(
  Map<String, dynamic> json,
) => _EstimateBudgetRequest(
  projectType: json['projectType'] as String,
  location: json['location'] as String?,
  duration: json['duration'] as String?,
  scenes: (json['scenes'] as num?)?.toInt(),
  characters: (json['characters'] as num?)?.toInt(),
  content: json['content'] as String?,
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$EstimateBudgetRequestToJson(
  _EstimateBudgetRequest instance,
) => <String, dynamic>{
  'projectType': instance.projectType,
  'location': instance.location,
  'duration': instance.duration,
  'scenes': instance.scenes,
  'characters': instance.characters,
  'content': instance.content,
  'provider': instance.provider,
};

_RecommendTalentRequest _$RecommendTalentRequestFromJson(
  Map<String, dynamic> json,
) => _RecommendTalentRequest(
  projectType: json['projectType'] as String,
  genre: json['genre'] as String?,
  budget: json['budget'] as String?,
  scale: json['scale'] as String? ?? 'independent',
  requirements: json['requirements'] as String?,
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$RecommendTalentRequestToJson(
  _RecommendTalentRequest instance,
) => <String, dynamic>{
  'projectType': instance.projectType,
  'genre': instance.genre,
  'budget': instance.budget,
  'scale': instance.scale,
  'requirements': instance.requirements,
  'provider': instance.provider,
};

_CreativeAssistRequest _$CreativeAssistRequestFromJson(
  Map<String, dynamic> json,
) => _CreativeAssistRequest(
  query: json['query'] as String,
  projectContext: json['projectContext'] as String?,
  context: json['context'] as String?,
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$CreativeAssistRequestToJson(
  _CreativeAssistRequest instance,
) => <String, dynamic>{
  'query': instance.query,
  'projectContext': instance.projectContext,
  'context': instance.context,
  'provider': instance.provider,
};

_ProjectInsightsRequest _$ProjectInsightsRequestFromJson(
  Map<String, dynamic> json,
) => _ProjectInsightsRequest(
  projectId: json['projectId'] as String,
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$ProjectInsightsRequestToJson(
  _ProjectInsightsRequest instance,
) => <String, dynamic>{
  'projectId': instance.projectId,
  'provider': instance.provider,
};

_ScriptDto _$ScriptDtoFromJson(Map<String, dynamic> json) => _ScriptDto(
  id: json['id'] as String,
  title: json['title'] as String,
  format: json['format'] as String,
  status: json['status'] as String?,
  content: json['content'] as String?,
  logline: json['logline'] as String?,
  synopsis: json['synopsis'] as String?,
  aiGenerated: json['aiGenerated'] as bool?,
  aiMetadata: json['aiMetadata'] == null
      ? null
      : AiMetadataDto.fromJson(json['aiMetadata'] as Map<String, dynamic>),
  version: (json['version'] as num?)?.toInt(),
  wordCount: (json['wordCount'] as num?)?.toInt(),
  pageCount: (json['pageCount'] as num?)?.toInt(),
  estimatedDuration: (json['estimatedDuration'] as num?)?.toInt(),
  project: json['project'] as String?,
  author: json['author'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ScriptDtoToJson(_ScriptDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'format': instance.format,
      'status': instance.status,
      'content': instance.content,
      'logline': instance.logline,
      'synopsis': instance.synopsis,
      'aiGenerated': instance.aiGenerated,
      'aiMetadata': instance.aiMetadata,
      'version': instance.version,
      'wordCount': instance.wordCount,
      'pageCount': instance.pageCount,
      'estimatedDuration': instance.estimatedDuration,
      'project': instance.project,
      'author': instance.author,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_AiMetadataDto _$AiMetadataDtoFromJson(Map<String, dynamic> json) =>
    _AiMetadataDto(
      provider: json['provider'] as String?,
      model: json['model'] as String?,
      tokensUsed: (json['tokensUsed'] as num?)?.toInt(),
      generationTimeMs: (json['generationTimeMs'] as num?)?.toInt(),
      generatedAt: json['generatedAt'] == null
          ? null
          : DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$AiMetadataDtoToJson(_AiMetadataDto instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'model': instance.model,
      'tokensUsed': instance.tokensUsed,
      'generationTimeMs': instance.generationTimeMs,
      'generatedAt': instance.generatedAt?.toIso8601String(),
    };

_AiResponseMeta _$AiResponseMetaFromJson(Map<String, dynamic> json) =>
    _AiResponseMeta(
      templateId: json['templateId'] as String?,
      provider: json['provider'] as String?,
      model: json['model'] as String?,
      tokensUsed: (json['tokensUsed'] as num?)?.toInt(),
      generationTimeMs: (json['generationTimeMs'] as num?)?.toInt(),
      cached: json['cached'] as bool? ?? false,
      warnings: (json['warnings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AiResponseMetaToJson(_AiResponseMeta instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'provider': instance.provider,
      'model': instance.model,
      'tokensUsed': instance.tokensUsed,
      'generationTimeMs': instance.generationTimeMs,
      'cached': instance.cached,
      'warnings': instance.warnings,
    };

_StoryEnhancementDto _$StoryEnhancementDtoFromJson(Map<String, dynamic> json) =>
    _StoryEnhancementDto(
      overallScore: (json['overallScore'] as num?)?.toInt(),
      strengths: (json['strengths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      weaknesses: (json['weaknesses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map(
            (e) => EnhancementSuggestionDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      enhancedLogline: json['enhancedLogline'] as String?,
      paceAnalysis: json['paceAnalysis'] as Map<String, dynamic>?,
      characterNotes: (json['characterNotes'] as List<dynamic>?)
          ?.map((e) => CharacterNoteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryEnhancementDtoToJson(
  _StoryEnhancementDto instance,
) => <String, dynamic>{
  'overallScore': instance.overallScore,
  'strengths': instance.strengths,
  'weaknesses': instance.weaknesses,
  'suggestions': instance.suggestions,
  'enhancedLogline': instance.enhancedLogline,
  'paceAnalysis': instance.paceAnalysis,
  'characterNotes': instance.characterNotes,
};

_EnhancementSuggestionDto _$EnhancementSuggestionDtoFromJson(
  Map<String, dynamic> json,
) => _EnhancementSuggestionDto(
  area: json['area'] as String?,
  severity: json['severity'] as String?,
  description: json['description'] as String?,
  affectedScenes: (json['affectedScenes'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  example: json['example'] as String?,
);

Map<String, dynamic> _$EnhancementSuggestionDtoToJson(
  _EnhancementSuggestionDto instance,
) => <String, dynamic>{
  'area': instance.area,
  'severity': instance.severity,
  'description': instance.description,
  'affectedScenes': instance.affectedScenes,
  'example': instance.example,
};

_CharacterNoteDto _$CharacterNoteDtoFromJson(Map<String, dynamic> json) =>
    _CharacterNoteDto(
      character: json['character'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CharacterNoteDtoToJson(_CharacterNoteDto instance) =>
    <String, dynamic>{'character': instance.character, 'note': instance.note};

_GenreAnalysisDto _$GenreAnalysisDtoFromJson(Map<String, dynamic> json) =>
    _GenreAnalysisDto(
      primaryGenre: json['primaryGenre'] as String?,
      subGenres: (json['subGenres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genreConfidence: (json['genreConfidence'] as num?)?.toDouble(),
      genreElements: (json['genreElements'] as List<dynamic>?)
          ?.map((e) => GenreElementDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      comparableFilms: (json['comparableFilms'] as List<dynamic>?)
          ?.map((e) => ComparableFilmDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      audienceProfile: json['audienceProfile'] as Map<String, dynamic>?,
      marketViability: json['marketViability'] as Map<String, dynamic>?,
      toneAnalysis: json['toneAnalysis'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GenreAnalysisDtoToJson(_GenreAnalysisDto instance) =>
    <String, dynamic>{
      'primaryGenre': instance.primaryGenre,
      'subGenres': instance.subGenres,
      'genreConfidence': instance.genreConfidence,
      'genreElements': instance.genreElements,
      'comparableFilms': instance.comparableFilms,
      'audienceProfile': instance.audienceProfile,
      'marketViability': instance.marketViability,
      'toneAnalysis': instance.toneAnalysis,
    };

_GenreElementDto _$GenreElementDtoFromJson(Map<String, dynamic> json) =>
    _GenreElementDto(
      element: json['element'] as String?,
      present: json['present'] as bool?,
      strength: json['strength'] as String?,
    );

Map<String, dynamic> _$GenreElementDtoToJson(_GenreElementDto instance) =>
    <String, dynamic>{
      'element': instance.element,
      'present': instance.present,
      'strength': instance.strength,
    };

_ComparableFilmDto _$ComparableFilmDtoFromJson(Map<String, dynamic> json) =>
    _ComparableFilmDto(
      title: json['title'] as String?,
      year: (json['year'] as num?)?.toInt(),
      similarity: (json['similarity'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ComparableFilmDtoToJson(_ComparableFilmDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'similarity': instance.similarity,
      'reason': instance.reason,
    };

_BudgetEstimationDto _$BudgetEstimationDtoFromJson(Map<String, dynamic> json) =>
    _BudgetEstimationDto(
      totalEstimate: json['totalEstimate'] == null
          ? null
          : BudgetTotalDto.fromJson(
              json['totalEstimate'] as Map<String, dynamic>,
            ),
      breakdown: (json['breakdown'] as List<dynamic>?)
          ?.map((e) => BudgetItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      assumptions: (json['assumptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      costDrivers: (json['costDrivers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      savingOpportunities: (json['savingOpportunities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      productionSchedule: json['productionSchedule'] as Map<String, dynamic>?,
      riskFactors: (json['riskFactors'] as List<dynamic>?)
          ?.map((e) => BudgetRiskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BudgetEstimationDtoToJson(
  _BudgetEstimationDto instance,
) => <String, dynamic>{
  'totalEstimate': instance.totalEstimate,
  'breakdown': instance.breakdown,
  'assumptions': instance.assumptions,
  'costDrivers': instance.costDrivers,
  'savingOpportunities': instance.savingOpportunities,
  'productionSchedule': instance.productionSchedule,
  'riskFactors': instance.riskFactors,
};

_BudgetTotalDto _$BudgetTotalDtoFromJson(Map<String, dynamic> json) =>
    _BudgetTotalDto(
      low: (json['low'] as num?)?.toDouble(),
      mid: (json['mid'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$BudgetTotalDtoToJson(_BudgetTotalDto instance) =>
    <String, dynamic>{
      'low': instance.low,
      'mid': instance.mid,
      'high': instance.high,
      'currency': instance.currency,
    };

_BudgetItemDto _$BudgetItemDtoFromJson(Map<String, dynamic> json) =>
    _BudgetItemDto(
      category: json['category'] as String?,
      description: json['description'] as String?,
      low: (json['low'] as num?)?.toDouble(),
      mid: (json['mid'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      percentage: (json['percentage'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BudgetItemDtoToJson(_BudgetItemDto instance) =>
    <String, dynamic>{
      'category': instance.category,
      'description': instance.description,
      'low': instance.low,
      'mid': instance.mid,
      'high': instance.high,
      'percentage': instance.percentage,
      'notes': instance.notes,
    };

_BudgetRiskDto _$BudgetRiskDtoFromJson(Map<String, dynamic> json) =>
    _BudgetRiskDto(
      factor: json['factor'] as String?,
      impact: json['impact'] as String?,
    );

Map<String, dynamic> _$BudgetRiskDtoToJson(_BudgetRiskDto instance) =>
    <String, dynamic>{'factor': instance.factor, 'impact': instance.impact};

_TalentRecommendationDto _$TalentRecommendationDtoFromJson(
  Map<String, dynamic> json,
) => _TalentRecommendationDto(
  roles: (json['roles'] as List<dynamic>?)
      ?.map((e) => TalentRoleDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  teamSize: json['teamSize'] as Map<String, dynamic>?,
  departmentBreakdown: (json['departmentBreakdown'] as List<dynamic>?)
      ?.map((e) => e as Map<String, dynamic>)
      .toList(),
  hiringTimeline: json['hiringTimeline'] as String?,
  budgetConsiderations: json['budgetConsiderations'] as String?,
);

Map<String, dynamic> _$TalentRecommendationDtoToJson(
  _TalentRecommendationDto instance,
) => <String, dynamic>{
  'roles': instance.roles,
  'teamSize': instance.teamSize,
  'departmentBreakdown': instance.departmentBreakdown,
  'hiringTimeline': instance.hiringTimeline,
  'budgetConsiderations': instance.budgetConsiderations,
};

_TalentRoleDto _$TalentRoleDtoFromJson(Map<String, dynamic> json) =>
    _TalentRoleDto(
      title: json['title'] as String?,
      department: json['department'] as String?,
      priority: json['priority'] as String?,
      description: json['description'] as String?,
      skillsRequired: (json['skillsRequired'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      experienceLevel: json['experienceLevel'] as String?,
      estimatedRate: json['estimatedRate'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TalentRoleDtoToJson(_TalentRoleDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'department': instance.department,
      'priority': instance.priority,
      'description': instance.description,
      'skillsRequired': instance.skillsRequired,
      'experienceLevel': instance.experienceLevel,
      'estimatedRate': instance.estimatedRate,
      'notes': instance.notes,
    };

_CreativeAssistDto _$CreativeAssistDtoFromJson(Map<String, dynamic> json) =>
    _CreativeAssistDto(
      response: json['response'] as String?,
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      references: (json['references'] as List<dynamic>?)
          ?.map((e) => CreativeReferenceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextSteps: (json['nextSteps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relatedTopics: (json['relatedTopics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreativeAssistDtoToJson(_CreativeAssistDto instance) =>
    <String, dynamic>{
      'response': instance.response,
      'suggestions': instance.suggestions,
      'references': instance.references,
      'nextSteps': instance.nextSteps,
      'relatedTopics': instance.relatedTopics,
    };

_CreativeReferenceDto _$CreativeReferenceDtoFromJson(
  Map<String, dynamic> json,
) => _CreativeReferenceDto(
  title: json['title'] as String?,
  relevance: json['relevance'] as String?,
);

Map<String, dynamic> _$CreativeReferenceDtoToJson(
  _CreativeReferenceDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'relevance': instance.relevance,
};

_ProjectInsightsDto _$ProjectInsightsDtoFromJson(Map<String, dynamic> json) =>
    _ProjectInsightsDto(
      projectHealth: json['projectHealth'] == null
          ? null
          : ProjectHealthDto.fromJson(
              json['projectHealth'] as Map<String, dynamic>,
            ),
      insights: (json['insights'] as List<dynamic>?)
          ?.map(
            (e) => ProjectInsightItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      predictions: json['predictions'] as Map<String, dynamic>?,
      benchmarks: json['benchmarks'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProjectInsightsDtoToJson(_ProjectInsightsDto instance) =>
    <String, dynamic>{
      'projectHealth': instance.projectHealth,
      'insights': instance.insights,
      'predictions': instance.predictions,
      'benchmarks': instance.benchmarks,
    };

_ProjectHealthDto _$ProjectHealthDtoFromJson(Map<String, dynamic> json) =>
    _ProjectHealthDto(
      score: (json['score'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ProjectHealthDtoToJson(_ProjectHealthDto instance) =>
    <String, dynamic>{'score': instance.score, 'status': instance.status};

_ProjectInsightItemDto _$ProjectInsightItemDtoFromJson(
  Map<String, dynamic> json,
) => _ProjectInsightItemDto(
  type: json['type'] as String?,
  priority: json['priority'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  actionRequired: json['actionRequired'] as bool?,
  suggestedAction: json['suggestedAction'] as String?,
);

Map<String, dynamic> _$ProjectInsightItemDtoToJson(
  _ProjectInsightItemDto instance,
) => <String, dynamic>{
  'type': instance.type,
  'priority': instance.priority,
  'title': instance.title,
  'description': instance.description,
  'actionRequired': instance.actionRequired,
  'suggestedAction': instance.suggestedAction,
};

_AiRecommendationDto _$AiRecommendationDtoFromJson(Map<String, dynamic> json) =>
    _AiRecommendationDto(
      suggestedCreators: json['suggestedCreators'] as List<dynamic>?,
      suggestedProjects: json['suggestedProjects'] as List<dynamic>?,
      suggestedSkills: json['suggestedSkills'] as List<dynamic>?,
    );

Map<String, dynamic> _$AiRecommendationDtoToJson(
  _AiRecommendationDto instance,
) => <String, dynamic>{
  'suggestedCreators': instance.suggestedCreators,
  'suggestedProjects': instance.suggestedProjects,
  'suggestedSkills': instance.suggestedSkills,
};

_AiJobStatusDto _$AiJobStatusDtoFromJson(Map<String, dynamic> json) =>
    _AiJobStatusDto(
      jobId: json['jobId'] as String?,
      status: json['status'] as String?,
      templateId: json['templateId'] as String?,
      progress: (json['progress'] as num?)?.toDouble(),
      attemptsMade: (json['attemptsMade'] as num?)?.toInt(),
      result: json['result'] as Map<String, dynamic>?,
      error: json['error'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$AiJobStatusDtoToJson(_AiJobStatusDto instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'status': instance.status,
      'templateId': instance.templateId,
      'progress': instance.progress,
      'attemptsMade': instance.attemptsMade,
      'result': instance.result,
      'error': instance.error,
      'createdAt': instance.createdAt?.toIso8601String(),
      'processedAt': instance.processedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_AiDashboardDto _$AiDashboardDtoFromJson(Map<String, dynamic> json) =>
    _AiDashboardDto(
      overview: json['overview'] == null
          ? null
          : AiDashboardOverviewDto.fromJson(
              json['overview'] as Map<String, dynamic>,
            ),
      providers: json['providers'] as Map<String, dynamic>?,
      templates: json['templates'] as Map<String, dynamic>?,
      recentErrors: (json['recentErrors'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$AiDashboardDtoToJson(_AiDashboardDto instance) =>
    <String, dynamic>{
      'overview': instance.overview,
      'providers': instance.providers,
      'templates': instance.templates,
      'recentErrors': instance.recentErrors,
    };

_AiDashboardOverviewDto _$AiDashboardOverviewDtoFromJson(
  Map<String, dynamic> json,
) => _AiDashboardOverviewDto(
  totalRequests: (json['totalRequests'] as num?)?.toInt(),
  totalTokens: (json['totalTokens'] as num?)?.toInt(),
  totalCost: json['totalCost'] as String?,
  averageLatency: json['averageLatency'] as String?,
  errorRate: json['errorRate'] as String?,
  cacheHitRate: json['cacheHitRate'] as String?,
);

Map<String, dynamic> _$AiDashboardOverviewDtoToJson(
  _AiDashboardOverviewDto instance,
) => <String, dynamic>{
  'totalRequests': instance.totalRequests,
  'totalTokens': instance.totalTokens,
  'totalCost': instance.totalCost,
  'averageLatency': instance.averageLatency,
  'errorRate': instance.errorRate,
  'cacheHitRate': instance.cacheHitRate,
};

_AiUsageStatsDto _$AiUsageStatsDtoFromJson(Map<String, dynamic> json) =>
    _AiUsageStatsDto(
      requests: (json['requests'] as num?)?.toInt() ?? 0,
      tokens: (json['tokens'] as num?)?.toInt() ?? 0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AiUsageStatsDtoToJson(_AiUsageStatsDto instance) =>
    <String, dynamic>{
      'requests': instance.requests,
      'tokens': instance.tokens,
      'cost': instance.cost,
    };

_AiProviderInfoDto _$AiProviderInfoDtoFromJson(Map<String, dynamic> json) =>
    _AiProviderInfoDto(
      providers: (json['providers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      health: json['health'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AiProviderInfoDtoToJson(_AiProviderInfoDto instance) =>
    <String, dynamic>{
      'providers': instance.providers,
      'health': instance.health,
    };
