/// Data models for AI Film Cost Predictor
library;

// Enum for equipment level
enum EquipmentLevel {
  basic('Basic - DSLR, basic lighting'),
  professional('Professional - Cinema cameras, advanced lighting'),
  premium('Premium - Full production suite');

  const EquipmentLevel(this.label);
  final String label;
}

/// Request model for cost prediction
class CostPredictionRequest {
  final String scriptDescription;
  final int numberOfActors;
  final int numberOfLocations;
  final EquipmentLevel equipmentLevel;
  final String? additionalDetails;

  CostPredictionRequest({
    required this.scriptDescription,
    required this.numberOfActors,
    required this.numberOfLocations,
    required this.equipmentLevel,
    this.additionalDetails,
  });

  Map<String, dynamic> toJson() => {
    'scriptDescription': scriptDescription,
    'numberOfActors': numberOfActors,
    'numberOfLocations': numberOfLocations,
    'equipmentLevel': equipmentLevel.label,
    'additionalDetails': additionalDetails ?? '',
  };
}

/// Cost breakdown model
class CostBreakdown {
  final double actors;
  final double equipment;
  final double editing;
  final double marketing;
  final double other;

  CostBreakdown({
    required this.actors,
    required this.equipment,
    required this.editing,
    required this.marketing,
    required this.other,
  });

  double get total => actors + equipment + editing + marketing + other;

  factory CostBreakdown.fromJson(Map<String, dynamic> json) {
    return CostBreakdown(
      actors: _parseDouble(json['actors']),
      equipment: _parseDouble(json['equipment']),
      editing: _parseDouble(json['editing']),
      marketing: _parseDouble(json['marketing']),
      other: _parseDouble(json['other']),
    );
  }

  Map<String, dynamic> toJson() => {
    'actors': actors,
    'equipment': equipment,
    'editing': editing,
    'marketing': marketing,
    'other': other,
  };

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

/// Response model for cost prediction
class CostPredictionResponse {
  final double totalEstimatedBudget;
  final CostBreakdown breakdown;
  final String rationale;
  final DateTime generatedAt;

  CostPredictionResponse({
    required this.totalEstimatedBudget,
    required this.breakdown,
    required this.rationale,
    required this.generatedAt,
  });

  factory CostPredictionResponse.fromJson(Map<String, dynamic> json) {
    return CostPredictionResponse(
      totalEstimatedBudget: _parseDouble(json['totalEstimatedBudget']),
      breakdown: CostBreakdown.fromJson(json['breakdown'] ?? {}),
      rationale: json['rationale'] ?? '',
      generatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalEstimatedBudget': totalEstimatedBudget,
    'breakdown': breakdown.toJson(),
    'rationale': rationale,
    'generatedAt': generatedAt.toIso8601String(),
  };

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
