import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/cost_prediction_models.dart';

/// Service for predicting film production costs using Gemini API
class FilmCostPredictorService {
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _model = 'gemini-2.5-flash';
  
  final String _apiKey;

  FilmCostPredictorService({required String apiKey}) : _apiKey = apiKey;

  /// Predict film production costs based on parameters
  Future<CostPredictionResponse> predictCost(
    CostPredictionRequest request,
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
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 2048,
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
          'Failed to predict cost: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error predicting cost: $e');
    }
  }

  /// Build the prompt for Gemini API
  String _buildPrompt(CostPredictionRequest request) {
    return '''Provide a film production cost estimate for the following project:

PARAMETERS:
- Script Description: ${request.scriptDescription}
- Number of Actors: ${request.numberOfActors}
- Number of Locations: ${request.numberOfLocations}
- Equipment Level: ${request.equipmentLevel.label}
${request.additionalDetails?.isNotEmpty ?? false ? '- Additional Details: ${request.additionalDetails}' : ''}

Based on industry standards, provide a detailed cost breakdown in USD.

Please respond ONLY with this exact JSON format (no markdown, no extra text):
{
  "totalEstimatedBudget": 50000,
  "breakdown": {
    "actors": 12000,
    "equipment": 15000,
    "editing": 10000,
    "marketing": 8000,
    "other": 5000
  },
  "rationale": "Detailed explanation of the budget breakdown and how you calculated each component based on industry standards."
}

IMPORTANT INSTRUCTIONS:
1. Return ONLY valid JSON, no additional text or markdown
2. All numbers must be realistic industry estimates
3. Consider location expenses, actor rates, and equipment rental costs
4. Include contingency in "other" category (typically 10% of total)
5. Provide detailed rationale explaining each cost component
6. All values must be positive numbers (no strings for amounts)''';
  }

  /// Parse the API response
  CostPredictionResponse _parseResponse(String responseBody) {
    try {
      final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
      
      if (jsonResponse['candidates'] == null || 
          (jsonResponse['candidates'] as List).isEmpty) {
        return _createDefaultResponse('No content generated from API');
      }

      final content = jsonResponse['candidates'][0]['content']['parts'][0]['text'] as String;
      
      // Try to find and parse JSON in the response
      try {
        // First, try to parse the entire content as JSON
        final costJson = jsonDecode(content);
        if (costJson is Map<String, dynamic> && costJson.containsKey('totalEstimatedBudget')) {
          return CostPredictionResponse.fromJson(costJson);
        }
      } catch (e) {
        // If that fails, try to extract JSON from the text
      }

      // Extract JSON object from the response
      final jsonMatch = _extractJsonFromText(content);
      if (jsonMatch != null && jsonMatch.isNotEmpty) {
        try {
          final costJson = jsonDecode(jsonMatch) as Map<String, dynamic>;
          return CostPredictionResponse.fromJson(costJson);
        } catch (e) {
          return _createDefaultResponse('Extracted but parsing failed');
        }
      }

      // If no JSON found, still return a response
      return _createDefaultResponse('Content: $content');
    } catch (e) {
      return _createDefaultResponse('Error parsing: $e');
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

  /// Create a default cost prediction response
  CostPredictionResponse _createDefaultResponse(String rationale) {
    return CostPredictionResponse(
      totalEstimatedBudget: 50000,
      breakdown: CostBreakdown(
        actors: 12000,
        equipment: 15000,
        editing: 10000,
        marketing: 8000,
        other: 5000,
      ),
      rationale: rationale,
      generatedAt: DateTime.now(),
    );
  }
}
