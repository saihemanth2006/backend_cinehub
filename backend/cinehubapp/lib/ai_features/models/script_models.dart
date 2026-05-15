/// Data models for AI Script Generator
library;

// Enum for script genre
enum ScriptGenre {
  action('Action'),
  romance('Romance'),
  thriller('Thriller'),
  comedy('Comedy'),
  drama('Drama'),
  horror('Horror'),
  scifi('Science Fiction');

  const ScriptGenre(this.label);
  final String label;
}

// Enum for script duration
enum ScriptDuration {
  fiveMin('5 min'),
  tenMin('10 min'),
  fifteenMin('15 min'),
  twentyMin('20 min');

  const ScriptDuration(this.label);
  final String label;
}

// Enum for script style
enum ScriptStyle {
  cinematic('Cinematic'),
  comedy('Comedy'),
  dark('Dark'),
  documentary('Documentary'),
  experimental('Experimental');

  const ScriptStyle(this.label);
  final String label;
}

/// Request model for script generation
class ScriptGenerationRequest {
  final ScriptGenre genre;
  final ScriptDuration duration;
  final String theme;
  final List<String>? characters;
  final ScriptStyle style;
  final String? additionalNotes;

  ScriptGenerationRequest({
    required this.genre,
    required this.duration,
    required this.theme,
    this.characters,
    required this.style,
    this.additionalNotes,
  });

  Map<String, dynamic> toJson() => {
    'genre': genre.label,
    'duration': duration.label,
    'theme': theme,
    'characters': characters ?? [],
    'style': style.label,
    'additionalNotes': additionalNotes ?? '',
  };
}

/// Response model for script generation
class ScriptGenerationResponse {
  final String storyOutline;
  final String screenplay;
  final List<String> dialogues;
  final List<String> shotSuggestions;
  final DateTime generatedAt;

  ScriptGenerationResponse({
    required this.storyOutline,
    required this.screenplay,
    required this.dialogues,
    required this.shotSuggestions,
    required this.generatedAt,
  });
  
  factory ScriptGenerationResponse.fromJson(Map<String, dynamic> json) {
    return ScriptGenerationResponse(
      storyOutline: json['storyOutline'] ?? '',
      screenplay: json['screenplay'] ?? '',
      dialogues: List<String>.from(json['dialogues'] ?? []),
      shotSuggestions: List<String>.from(json['shotSuggestions'] ?? []),
      generatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'storyOutline': storyOutline,
    'screenplay': screenplay,
    'dialogues': dialogues,
    'shotSuggestions': shotSuggestions,
    'generatedAt': generatedAt.toIso8601String(),
  };
}
