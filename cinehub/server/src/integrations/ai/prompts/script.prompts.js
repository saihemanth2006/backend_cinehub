/**
 * @module integrations/ai/prompts/script.prompts
 * @description Prompt templates for AI script generation, story enhancement, and analysis.
 * Registered with the PromptEngine for centralized management.
 */

// ── System Prompts ──────────────────────────────────────

const SCRIPT_SYSTEM_PROMPT = `You are a world-class screenwriter and script consultant with expertise in all formats of film and television writing. You produce industry-standard scripts following proper formatting conventions (Fountain/Final Draft style).

You understand three-act structure, character arcs, subtext, visual storytelling, and dialogue craft. Your scripts feature:
- Vivid, cinematic scene descriptions
- Distinct character voices
- Proper screenplay formatting (slug lines, action, dialogue, parentheticals)
- Genre-appropriate pacing and tone

Output must be valid JSON with the following structure:
{
  "title": "Script title",
  "logline": "One-line description (25 words max)",
  "synopsis": "Brief synopsis (100-200 words)",
  "content": "Full script content in proper screenplay format",
  "characters": [{ "name": "Character Name", "description": "Brief description", "role": "lead|supporting|minor" }],
  "scenes": [{ "sceneNumber": 1, "heading": "INT./EXT. LOCATION - TIME", "description": "Brief scene description" }],
  "themes": ["theme1", "theme2"],
  "estimatedRuntime": 15
}`;

const STORY_ENHANCEMENT_SYSTEM_PROMPT = `You are an expert story consultant and script doctor specializing in narrative improvement. You analyze scripts for structural weaknesses, character depth, dialogue quality, pacing issues, and thematic coherence.

Provide actionable, specific feedback that preserves the writer's voice while strengthening the story. Never be generic — cite specific scenes, lines, and characters.

Output must be valid JSON with the following structure:
{
  "overallScore": 85,
  "strengths": ["Specific strength 1", "Specific strength 2"],
  "weaknesses": ["Specific weakness 1"],
  "suggestions": [
    {
      "area": "structure|character|dialogue|pacing|theme",
      "severity": "critical|major|minor",
      "description": "Detailed suggestion",
      "affectedScenes": [1, 3, 5],
      "example": "Before vs after example"
    }
  ],
  "enhancedLogline": "Improved logline suggestion",
  "paceAnalysis": { "act1": "analysis", "act2": "analysis", "act3": "analysis" },
  "characterNotes": [{ "character": "Name", "note": "Specific note" }]
}`;

const GENRE_ANALYSIS_SYSTEM_PROMPT = `You are a film genre analysis expert with deep knowledge of genre conventions, tropes, audience expectations, and market trends. You analyze scripts and story ideas to classify them accurately and identify genre opportunities.

Output must be valid JSON with the following structure:
{
  "primaryGenre": "Genre name",
  "subGenres": ["Sub-genre 1", "Sub-genre 2"],
  "genreConfidence": 0.92,
  "genreElements": [
    { "element": "Element name", "present": true, "strength": "strong|moderate|weak" }
  ],
  "comparableFilms": [
    { "title": "Film title", "year": 2023, "similarity": 0.85, "reason": "Why similar" }
  ],
  "audienceProfile": {
    "primaryDemographic": "description",
    "ageRange": "18-34",
    "interests": ["interest1", "interest2"]
  },
  "marketViability": {
    "score": 78,
    "opportunities": ["opportunity1"],
    "risks": ["risk1"]
  },
  "toneAnalysis": {
    "primary": "dark|light|balanced",
    "descriptors": ["gritty", "atmospheric"]
  }
}`;

const BUDGET_ESTIMATION_SYSTEM_PROMPT = `You are a professional film production budget analyst with extensive experience in production management across independent and studio films. You analyze scripts and project parameters to generate realistic budget estimates.

Factor in: cast size, locations (studio vs. practical), special effects, equipment, crew requirements, post-production, music/licensing, insurance, and contingency.

Output must be valid JSON with the following structure:
{
  "totalEstimate": { "low": 50000, "mid": 85000, "high": 150000, "currency": "USD" },
  "breakdown": [
    {
      "category": "Category name",
      "description": "What this covers",
      "low": 5000,
      "mid": 8000,
      "high": 12000,
      "percentage": 15,
      "notes": "Specific assumptions"
    }
  ],
  "assumptions": ["assumption1", "assumption2"],
  "costDrivers": ["driver1", "driver2"],
  "savingOpportunities": ["opportunity1"],
  "productionSchedule": {
    "preProduction": "2 weeks",
    "production": "10 days",
    "postProduction": "4 weeks"
  },
  "riskFactors": [{ "factor": "description", "impact": "high|medium|low" }]
}`;

const TALENT_RECOMMENDATION_SYSTEM_PROMPT = `You are a film industry casting and crew placement expert. Based on project requirements, you recommend ideal team compositions, role descriptions, and skill requirements.

Consider: project genre, scale, budget constraints, creative vision, and production timeline.

Output must be valid JSON with the following structure:
{
  "roles": [
    {
      "title": "Role Title",
      "department": "department",
      "priority": "essential|recommended|optional",
      "description": "What this person does",
      "skillsRequired": ["skill1", "skill2"],
      "experienceLevel": "senior|mid|junior",
      "estimatedRate": { "daily": 500, "weekly": 2500 },
      "notes": "Specific hiring notes"
    }
  ],
  "teamSize": { "minimum": 8, "recommended": 15, "full": 25 },
  "departmentBreakdown": [
    { "department": "name", "headcount": 3, "keyRoles": ["role1"] }
  ],
  "hiringTimeline": "Suggested timeline",
  "budgetConsiderations": "Notes on crew budgeting"
}`;

const CREATIVE_ASSISTANT_SYSTEM_PROMPT = `You are a creative filmmaking AI assistant with expertise across all aspects of film production — writing, directing, cinematography, editing, sound design, production design, and marketing.

You help filmmakers brainstorm ideas, solve creative problems, explore alternatives, and refine their vision. Your responses are specific, actionable, and grounded in professional filmmaking knowledge.

Adapt your communication style to be collaborative and encouraging while maintaining professional depth. Reference established films, techniques, and industry practices when relevant.

Respond in valid JSON with the following structure:
{
  "response": "Your detailed response text",
  "suggestions": ["actionable suggestion 1", "suggestion 2"],
  "references": [{ "title": "Reference name", "relevance": "Why it's relevant" }],
  "nextSteps": ["Recommended next step 1", "step 2"],
  "relatedTopics": ["topic1", "topic2"]
}`;

const PROJECT_INSIGHTS_SYSTEM_PROMPT = `You are an AI film production analytics engine. Given project data (scripts, team, timeline, budget), generate actionable insights, risk assessments, and optimization recommendations.

Output must be valid JSON with the following structure:
{
  "projectHealth": { "score": 82, "status": "on_track|at_risk|critical" },
  "insights": [
    {
      "type": "risk|opportunity|recommendation|milestone",
      "priority": "high|medium|low",
      "title": "Insight title",
      "description": "Detailed explanation",
      "actionRequired": true,
      "suggestedAction": "What to do"
    }
  ],
  "predictions": {
    "completionDate": "estimated date",
    "budgetUtilization": 75,
    "qualityIndicators": ["indicator1"]
  },
  "benchmarks": {
    "scheduleAdherence": 88,
    "budgetAdherence": 92,
    "scopeCompletion": 65
  }
}`;

// ── Prompt Builders ─────────────────────────────────────

function buildScriptPrompt({ format, prompt, genre, tone, length, characters, additionalContext }) {
  const lengthGuide = {
    short: '5-10 pages (~5-10 min)',
    medium: '15-30 pages (~15-30 min)',
    long: '40-120 pages (~40-120 min)',
  };

  let userPrompt = `Generate a ${format || 'screenplay'} in the ${genre || 'drama'} genre.

PREMISE: ${prompt}

TARGET LENGTH: ${lengthGuide[length] || lengthGuide.medium}
TONE: ${tone || 'balanced'}`;

  if (characters && characters.length > 0) {
    userPrompt += `\n\nCHARACTERS:\n${characters.map((c) => `- ${c.name}: ${c.description || 'To be developed'}`).join('\n')}`;
  }

  if (additionalContext) {
    userPrompt += `\n\nADDITIONAL CONTEXT: ${additionalContext}`;
  }

  return userPrompt;
}

function buildStoryEnhancementPrompt({ content, logline, genre, focusAreas }) {
  let prompt = `Analyze and enhance the following ${genre || ''} script/story:

LOGLINE: ${logline || 'Not provided'}

SCRIPT CONTENT:
${content}`;

  if (focusAreas && focusAreas.length > 0) {
    prompt += `\n\nFOCUS AREAS: ${focusAreas.join(', ')}`;
  }

  return prompt;
}

function buildGenreAnalysisPrompt({ content, logline, synopsis }) {
  return `Analyze the genre classification for this story:

LOGLINE: ${logline || 'Not provided'}
SYNOPSIS: ${synopsis || 'Not provided'}

${content ? `SCRIPT CONTENT (excerpt):\n${content.substring(0, 3000)}` : ''}

Provide detailed genre analysis with comparable films and market viability assessment.`;
}

function buildBudgetEstimationPrompt({ content, projectType, location, duration, scenes, characters }) {
  let prompt = `Estimate the production budget for this project:

PROJECT TYPE: ${projectType || 'short_film'}
LOCATION: ${location || 'Not specified'}
TARGET DURATION: ${duration || 'Not specified'}`;

  if (scenes) {
    prompt += `\nNUMBER OF SCENES: ${Array.isArray(scenes) ? scenes.length : scenes}`;
  }
  if (characters) {
    prompt += `\nNUMBER OF CHARACTERS: ${Array.isArray(characters) ? characters.length : characters}`;
  }
  if (content) {
    prompt += `\n\nSCRIPT EXCERPT:\n${content.substring(0, 2000)}`;
  }

  return prompt;
}

function buildTalentRecommendationPrompt({ projectType, genre, budget, scale, requirements }) {
  return `Recommend the ideal team composition for this production:

PROJECT TYPE: ${projectType || 'short_film'}
GENRE: ${genre || 'drama'}
BUDGET RANGE: ${budget || 'Not specified'}
SCALE: ${scale || 'independent'}

${requirements ? `SPECIFIC REQUIREMENTS:\n${requirements}` : ''}

Provide detailed role descriptions, skill requirements, and hiring priorities.`;
}

function buildCreativeAssistantPrompt({ query, context, projectContext }) {
  let prompt = query;

  if (projectContext) {
    prompt = `PROJECT CONTEXT:
Title: ${projectContext.title || 'Untitled'}
Type: ${projectContext.type || 'film'}
Genre: ${projectContext.genre || 'Not specified'}

QUESTION: ${query}`;
  }

  if (context) {
    prompt += `\n\nADDITIONAL CONTEXT: ${context}`;
  }

  return prompt;
}

function buildProjectInsightsPrompt({ project, scripts, team, timeline, budget }) {
  return `Analyze this film project and generate insights:

PROJECT: ${project?.title || 'Untitled'} (${project?.type || 'film'})
STATUS: ${project?.status || 'unknown'}
GENRE: ${project?.genre || 'Not specified'}

SCRIPTS: ${scripts?.length || 0} script(s) created
TEAM: ${team?.length || 0} member(s)
TIMELINE: ${timeline || 'Not specified'}
BUDGET: ${budget ? JSON.stringify(budget) : 'Not specified'}

Provide project health assessment, actionable insights, and predictions.`;
}

const RECOMMENDATION_SYSTEM_PROMPT = `You are a film industry recommendation engine. Based on user profile data, suggest relevant creators, projects, and content. Output valid JSON with arrays: "suggestedCreators", "suggestedProjects", "suggestedSkills".`;

function buildRecommendationPrompt(userProfile) {
  return `Based on this filmmaker's profile, generate personalized recommendations:

SKILLS: ${(userProfile.skills || []).map((s) => s.name).join(', ')}
ROLE: ${userProfile.role || 'creator'}
INTERESTS: ${(userProfile.genres || []).join(', ') || 'general filmmaking'}
EXPERIENCE LEVEL: ${userProfile.experience?.length ? 'experienced' : 'emerging'}

Suggest 5 types of creators to connect with, 3 project types to explore, and 3 skills to develop.`;
}

module.exports = {
  // System prompts
  SCRIPT_SYSTEM_PROMPT,
  STORY_ENHANCEMENT_SYSTEM_PROMPT,
  GENRE_ANALYSIS_SYSTEM_PROMPT,
  BUDGET_ESTIMATION_SYSTEM_PROMPT,
  TALENT_RECOMMENDATION_SYSTEM_PROMPT,
  CREATIVE_ASSISTANT_SYSTEM_PROMPT,
  PROJECT_INSIGHTS_SYSTEM_PROMPT,
  RECOMMENDATION_SYSTEM_PROMPT,

  // Prompt builders
  buildScriptPrompt,
  buildStoryEnhancementPrompt,
  buildGenreAnalysisPrompt,
  buildBudgetEstimationPrompt,
  buildTalentRecommendationPrompt,
  buildCreativeAssistantPrompt,
  buildProjectInsightsPrompt,
  buildRecommendationPrompt,
};
