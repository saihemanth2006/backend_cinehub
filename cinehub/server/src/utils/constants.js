/**
 * @module utils/constants
 * @description Application-wide constants and enumerations.
 * Single source of truth for domain values used across models, services, and validations.
 */

const USER_ROLES = Object.freeze({
  USER: 'user',
  CREATOR: 'creator',
  PRODUCER: 'producer',
  ADMIN: 'admin',
  SUPER_ADMIN: 'superAdmin',
});

const PROJECT_STATUS = Object.freeze({
  DRAFT: 'draft',
  PRE_PRODUCTION: 'pre_production',
  IN_PRODUCTION: 'in_production',
  POST_PRODUCTION: 'post_production',
  COMPLETED: 'completed',
  ARCHIVED: 'archived',
});

const PROJECT_TYPES = Object.freeze({
  SHORT_FILM: 'short_film',
  FEATURE_FILM: 'feature_film',
  DOCUMENTARY: 'documentary',
  WEB_SERIES: 'web_series',
  MUSIC_VIDEO: 'music_video',
  COMMERCIAL: 'commercial',
  ANIMATION: 'animation',
});

const SCRIPT_STATUS = Object.freeze({
  GENERATING: 'generating',
  DRAFT: 'draft',
  IN_REVIEW: 'in_review',
  APPROVED: 'approved',
  REVISION: 'revision',
  FINAL: 'final',
});

const SCRIPT_FORMATS = Object.freeze({
  SCREENPLAY: 'screenplay',
  TREATMENT: 'treatment',
  OUTLINE: 'outline',
  BEAT_SHEET: 'beat_sheet',
  LOGLINE: 'logline',
  SYNOPSIS: 'synopsis',
});

const TEAM_ROLES = Object.freeze({
  OWNER: 'owner',
  DIRECTOR: 'director',
  PRODUCER: 'producer',
  WRITER: 'writer',
  CINEMATOGRAPHER: 'cinematographer',
  EDITOR: 'editor',
  ACTOR: 'actor',
  SOUND_DESIGNER: 'sound_designer',
  ART_DIRECTOR: 'art_director',
  VFX_ARTIST: 'vfx_artist',
  COMPOSER: 'composer',
  MEMBER: 'member',
});

const MEMBER_STATUS = Object.freeze({
  INVITED: 'invited',
  ACTIVE: 'active',
  INACTIVE: 'inactive',
  REMOVED: 'removed',
});

const MEDIA_TYPES = Object.freeze({
  IMAGE: 'image',
  VIDEO: 'video',
  AUDIO: 'audio',
  DOCUMENT: 'document',
  THUMBNAIL: 'thumbnail',
});

const PORTFOLIO_ITEM_TYPES = Object.freeze({
  FILM: 'film',
  CLIP: 'clip',
  SHOWREEL: 'showreel',
  BTS: 'behind_the_scenes',
  PHOTO: 'photo',
  POSTER: 'poster',
});

const NOTIFICATION_TYPES = Object.freeze({
  SYSTEM: 'system',
  PROJECT_INVITE: 'project_invite',
  TEAM_UPDATE: 'team_update',
  SCRIPT_READY: 'script_ready',
  COLLABORATION_REQUEST: 'collaboration_request',
  PORTFOLIO_LIKE: 'portfolio_like',
  PORTFOLIO_COMMENT: 'portfolio_comment',
  FOLLOW: 'follow',
  MENTION: 'mention',
  AI_RECOMMENDATION: 'ai_recommendation',
});

const NOTIFICATION_PRIORITY = Object.freeze({
  LOW: 'low',
  MEDIUM: 'medium',
  HIGH: 'high',
  URGENT: 'urgent',
});

const AI_PROVIDERS = Object.freeze({
  OPENAI: 'openai',
  GEMINI: 'gemini',
  ANTHROPIC: 'anthropic',
});

const AI_TEMPLATE_CATEGORIES = Object.freeze({
  SCRIPT: 'script',
  ANALYSIS: 'analysis',
  PRODUCTION: 'production',
  ASSISTANT: 'assistant',
  INSIGHTS: 'insights',
  RECOMMENDATION: 'recommendation',
});

const AI_JOB_STATUS = Object.freeze({
  QUEUED: 'queued',
  ACTIVE: 'active',
  COMPLETED: 'completed',
  FAILED: 'failed',
  DELAYED: 'delayed',
});

const SKILL_CATEGORIES = Object.freeze({
  DIRECTING: 'directing',
  CINEMATOGRAPHY: 'cinematography',
  WRITING: 'writing',
  EDITING: 'editing',
  ACTING: 'acting',
  PRODUCING: 'producing',
  SOUND: 'sound',
  VFX: 'vfx',
  ART: 'art',
  MUSIC: 'music',
  ANIMATION: 'animation',
  MARKETING: 'marketing',
});

const SORT_OPTIONS = Object.freeze({
  NEWEST: 'createdAt:desc',
  OLDEST: 'createdAt:asc',
  NAME_ASC: 'name:asc',
  NAME_DESC: 'name:desc',
  POPULAR: 'viewCount:desc',
  RATING: 'rating:desc',
});

module.exports = {
  USER_ROLES,
  PROJECT_STATUS,
  PROJECT_TYPES,
  SCRIPT_STATUS,
  SCRIPT_FORMATS,
  TEAM_ROLES,
  MEMBER_STATUS,
  MEDIA_TYPES,
  PORTFOLIO_ITEM_TYPES,
  NOTIFICATION_TYPES,
  NOTIFICATION_PRIORITY,
  AI_PROVIDERS,
  AI_TEMPLATE_CATEGORIES,
  AI_JOB_STATUS,
  SKILL_CATEGORIES,
  SORT_OPTIONS,
};
