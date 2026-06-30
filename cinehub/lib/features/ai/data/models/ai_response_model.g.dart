// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
  success: json['success'] as bool,
  module: json['module'] as String,
  task: json['task'] as String,
  data: json['data'],
  meta: AIResponseMeta.fromJson(json['meta'] as Map<String, dynamic>),
  error: json['error'] as String?,
);

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'module': instance.module,
      'task': instance.task,
      'data': instance.data,
      'meta': instance.meta,
      'error': instance.error,
    };

AIResponseMeta _$AIResponseMetaFromJson(Map<String, dynamic> json) =>
    AIResponseMeta(
      provider: json['provider'] as String,
      model: json['model'] as String?,
      tokensUsed: (json['tokensUsed'] as num?)?.toInt(),
      executionTimeMs: (json['executionTimeMs'] as num?)?.toInt(),
      cached: json['cached'] as bool? ?? false,
      requestId: json['requestId'] as String?,
      generatedAt: _parseDateTime(json['generatedAt']),
    );

Map<String, dynamic> _$AIResponseMetaToJson(AIResponseMeta instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'model': instance.model,
      'tokensUsed': instance.tokensUsed,
      'executionTimeMs': instance.executionTimeMs,
      'cached': instance.cached,
      'requestId': instance.requestId,
      'generatedAt': _formatDateTime(instance.generatedAt),
    };

ScriptDevelopmentResponse _$ScriptDevelopmentResponseFromJson(
  Map<String, dynamic> json,
) => ScriptDevelopmentResponse(
  title: json['title'] as String?,
  logline: json['logline'] as String?,
  synopsis: json['synopsis'] as String?,
  content: json['content'] as String?,
  characters: json['characters'] as List<dynamic>?,
  scenes: json['scenes'] as List<dynamic>?,
  themes: json['themes'] as List<dynamic>?,
  estimatedRuntime: (json['estimatedRuntime'] as num?)?.toInt(),
);

Map<String, dynamic> _$ScriptDevelopmentResponseToJson(
  ScriptDevelopmentResponse instance,
) => <String, dynamic>{
  'title': instance.title,
  'logline': instance.logline,
  'synopsis': instance.synopsis,
  'content': instance.content,
  'characters': instance.characters,
  'scenes': instance.scenes,
  'themes': instance.themes,
  'estimatedRuntime': instance.estimatedRuntime,
};

TrailerConceptResponse _$TrailerConceptResponseFromJson(
  Map<String, dynamic> json,
) => TrailerConceptResponse(
  narration: json['narration'] as String?,
  beats: json['beats'] as List<dynamic>?,
  hooks: json['hooks'] as List<dynamic>?,
  structure: json['structure'] as String?,
  musicMood: json['musicMood'] as List<dynamic>?,
  totalDuration: json['totalDuration'] as String?,
);

Map<String, dynamic> _$TrailerConceptResponseToJson(
  TrailerConceptResponse instance,
) => <String, dynamic>{
  'narration': instance.narration,
  'beats': instance.beats,
  'hooks': instance.hooks,
  'structure': instance.structure,
  'musicMood': instance.musicMood,
  'totalDuration': instance.totalDuration,
};

VideoEnhancementResponse _$VideoEnhancementResponseFromJson(
  Map<String, dynamic> json,
) => VideoEnhancementResponse(
  suggestions: json['suggestions'] as List<dynamic>?,
  colorPalette: json['colorPalette'] as Map<String, dynamic>?,
  subtitles: json['subtitles'] as List<dynamic>?,
  pacing: json['pacing'] as Map<String, dynamic>?,
  effects: json['effects'] as List<dynamic>?,
);

Map<String, dynamic> _$VideoEnhancementResponseToJson(
  VideoEnhancementResponse instance,
) => <String, dynamic>{
  'suggestions': instance.suggestions,
  'colorPalette': instance.colorPalette,
  'subtitles': instance.subtitles,
  'pacing': instance.pacing,
  'effects': instance.effects,
};

CastCrewResponse _$CastCrewResponseFromJson(Map<String, dynamic> json) =>
    CastCrewResponse(
      roles: json['roles'] as List<dynamic>?,
      talents: json['talents'] as List<dynamic>?,
      teamComposition: json['teamComposition'] as Map<String, dynamic>?,
      skills: json['skills'] as List<dynamic>?,
    );

Map<String, dynamic> _$CastCrewResponseToJson(CastCrewResponse instance) =>
    <String, dynamic>{
      'roles': instance.roles,
      'talents': instance.talents,
      'teamComposition': instance.teamComposition,
      'skills': instance.skills,
    };

ProductionIntelligenceResponse _$ProductionIntelligenceResponseFromJson(
  Map<String, dynamic> json,
) => ProductionIntelligenceResponse(
  budget: json['budget'] as Map<String, dynamic>?,
  schedule: json['schedule'] as Map<String, dynamic>?,
  equipment: json['equipment'] as List<dynamic>?,
  complexity: json['complexity'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ProductionIntelligenceResponseToJson(
  ProductionIntelligenceResponse instance,
) => <String, dynamic>{
  'budget': instance.budget,
  'schedule': instance.schedule,
  'equipment': instance.equipment,
  'complexity': instance.complexity,
};

DistributionPromotionResponse _$DistributionPromotionResponseFromJson(
  Map<String, dynamic> json,
) => DistributionPromotionResponse(
  festivals: json['festivals'] as List<dynamic>?,
  audience: json['audience'] as Map<String, dynamic>?,
  captions: json['captions'] as List<dynamic>?,
  strategy: json['strategy'] as Map<String, dynamic>?,
  copywriting: json['copywriting'] as String?,
);

Map<String, dynamic> _$DistributionPromotionResponseToJson(
  DistributionPromotionResponse instance,
) => <String, dynamic>{
  'festivals': instance.festivals,
  'audience': instance.audience,
  'captions': instance.captions,
  'strategy': instance.strategy,
  'copywriting': instance.copywriting,
};

PreVisualizationResponse _$PreVisualizationResponseFromJson(
  Map<String, dynamic> json,
) => PreVisualizationResponse(
  shots: json['shots'] as List<dynamic>?,
  cameraAngles: json['cameraAngles'] as List<dynamic>?,
  moodboardPrompts: json['moodboardPrompts'] as List<dynamic>?,
  lighting: json['lighting'] as Map<String, dynamic>?,
  visualStorytelling: json['visualStorytelling'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PreVisualizationResponseToJson(
  PreVisualizationResponse instance,
) => <String, dynamic>{
  'shots': instance.shots,
  'cameraAngles': instance.cameraAngles,
  'moodboardPrompts': instance.moodboardPrompts,
  'lighting': instance.lighting,
  'visualStorytelling': instance.visualStorytelling,
};
