import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/script_models.dart';

/// Service for generating scripts using Gemini API
class ScriptGeneratorService {
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _model = 'gemini-2.5-flash'; // Available model
  // static const String _model = 'gemini-1.5-flash'; // Alternative: faster
  
  final String _apiKey;

  ScriptGeneratorService({required String apiKey}) : _apiKey = apiKey;

  /// Generate a complete script based on the provided parameters
  Future<ScriptGenerationResponse> generateScript(
    ScriptGenerationRequest request,
  ) async {
    try {
      final prompt = _buildPrompt(request);
      
      final response = await http.post(
        Uri.parse('$_baseUrl/$_model:generateContent?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': prompt,
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.9,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 4096,
          },
        }),
      ).timeout(
        const Duration(minutes: 2),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        return _parseResponse(response.body);
      } else {
        throw Exception(
          'Failed to generate script: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error generating script: $e');
    }
  }

  /// Build the prompt for Gemini API
  String _buildPrompt(ScriptGenerationRequest request) {
    final charactersText = request.characters?.isEmpty ?? true
        ? 'Create original characters'
        : 'Characters: ${request.characters?.join(', ')}';

    return '''Generate a complete ${request.duration.label} ${request.genre.label} screenplay with ${request.style.label} style.

PARAMETERS:
- Genre: ${request.genre.label}
- Duration: ${request.duration.label}
- Theme/Message: ${request.theme}
- $charactersText
- Style: ${request.style.label}
${request.additionalNotes?.isNotEmpty ?? false ? '- Additional Notes: ${request.additionalNotes}' : ''}

Please provide the output in this EXACT JSON format (no markdown, just pure JSON):
{
  "storyOutline": "A detailed story outline with beginning, middle, and end (2-3 paragraphs)",
  "screenplay": "Complete screenplay divided by scenes with scene headings, action lines, character names, dialogue, and parentheticals. Format each scene clearly.",
  "dialogues": ["Dialogue 1", "Dialogue 2", "Dialogue 3", ...],
  "shotSuggestions": ["Shot 1: Description of camera angle and movement", "Shot 2: Description", ...]
}

IMPORTANT: 
1. Return ONLY valid JSON, no additional text
2. Ensure the screenplay is detailed and production-ready
3. Include at least 5-8 key dialogues
4. Provide 8-12 specific shot suggestions with camera descriptions
5. Make the story compelling and adhere to the specified theme and style''';
  }

  /// Parse the API response
  ScriptGenerationResponse _parseResponse(String responseBody) {
    try {
      final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
      
      if (jsonResponse['candidates'] == null || 
          (jsonResponse['candidates'] as List).isEmpty) {
        return _createDefaultScriptResponse('No content generated from API');
      }

      final content = jsonResponse['candidates'][0]['content']['parts'][0]['text'] as String;
      
      // Try to parse the entire content as JSON first
      try {
        final scriptJson = jsonDecode(content);
        if (scriptJson is Map<String, dynamic> && scriptJson.containsKey('storyOutline')) {
          return ScriptGenerationResponse.fromJson(scriptJson);
        }
      } catch (e) {
        // If that fails, try to extract JSON from the text
      }

      // Extract JSON object from the response
      final jsonMatch = _extractJsonFromText(content);
      if (jsonMatch != null && jsonMatch.isNotEmpty) {
        try {
          final scriptJson = jsonDecode(jsonMatch) as Map<String, dynamic>;
          return ScriptGenerationResponse.fromJson(scriptJson);
        } catch (e) {
          return _createDefaultScriptResponse('Extracted but parsing failed');
        }
      }

      // If no JSON found, create a default response
      return _createDefaultScriptResponse(content);
    } catch (e) {
      return _createDefaultScriptResponse('Error: $e\nResponse: $responseBody');
    }
  }

  /// Extract JSON object from text
  String? _extractJsonFromText(String text) {
    int braceCount = 0;
    int startIndex = -1;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '{') {
        if (braceCount == 0) {
          startIndex = i;
        }
        braceCount++;
      } else if (text[i] == '}') {
        braceCount--;
        if (braceCount == 0 && startIndex != -1) {
          return text.substring(startIndex, i + 1);
        }
      }
    }

    return null;
  }

  /// Create a default script response
  ScriptGenerationResponse _createDefaultScriptResponse(String content) {
    return ScriptGenerationResponse(
      storyOutline: content,
      screenplay: 'Screenplay generation in progress...',
      dialogues: ['Dialogue pending...'],
      shotSuggestions: ['Shot pending...'],
      generatedAt: DateTime.now(),
    );
  }
}
