///
/// @file ai_service.dart
/// @description Centralized AI service layer — wrapper around /ai/generate API endpoint
/// Handles all AI API calls with caching, error handling, and request management.
///
library;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinehub/core/network/api_client.dart';
import 'package:cinehub/core/di/providers.dart';
import '../data/models/ai_request_model.dart';
import '../data/models/ai_response_model.dart';

/// AI Service — Single entry point for all AI API operations
class AIService {
  final Dio _dio;

  AIService(Dio dio) : _dio = dio;

  /// Execute unified AI generation request
  /// 
  /// [module] - AI module (script-development, trailer-concept, etc.)
  /// [task] - Task within module (generate-script, enhance-dialogue, etc.)
  /// [input] - Raw user input (string or structured object)
  /// [options] - Optional generation parameters
  ///
  /// Returns: Structured AI response with data, metadata, and formatting
  Future<AIResponse> generate({
    required String module,
    required String task,
    required dynamic input,
    Map<String, dynamic>? options,
  }) async {
    try {
      final request = AIRequest(
        module: module,
        task: task,
        input: input,
        options: options,
      );

      final response = await _dio.post(
        '/ai/generate',
        data: request.toJson(),
      );

      return AIResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('AI Generation Error: $e');
    }
  }

  /// Get all available AI capabilities (modules and tasks)
  Future<Map<String, dynamic>> getCapabilities() async {
    try {
      final response = await _dio.get('/ai/capabilities');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// List all supported modules
  Future<List<String>> getModules() async {
    try {
      final response = await _dio.get('/ai/modules');
      return List<String>.from(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get tasks for a specific module
  Future<List<AITask>> getModuleTasks(String module) async {
    try {
      final response = await _dio.get('/ai/modules/$module/tasks');
      final tasks = (response.data as List)
          .map((t) => AITask.fromJson(t))
          .toList();
      return tasks;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get health status of AI system
  Future<Map<String, dynamic>> getHealth() async {
    try {
      final response = await _dio.get('/ai/health');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get current user's AI usage stats
  Future<Map<String, dynamic>> getUsageStats() async {
    try {
      final response = await _dio.get('/ai/usage');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ── Error Handling ───────────────────────────────────

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Request timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Request failed';
        return Exception('Error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.unknown:
        return Exception('Network error: ${e.message}');
      default:
        return Exception('Unknown error occurred');
    }
  }
}

/// AI Task Model
class AITask {
  final String task;
  final String name;
  final String description;

  AITask({
    required this.task,
    required this.name,
    required this.description,
  });

  factory AITask.fromJson(Map<String, dynamic> json) {
    return AITask(
      task: json['task'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

// ── Riverpod Providers ───────────────────────────────

/// Singleton AI Service provider
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService(ref.watch(apiClientProvider).dio);
});

/// Provider for getting AI capabilities (legacy — prefer aiCapabilitiesProvider from ai_providers.dart)
final aiLegacyCapabilitiesProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(aiServiceProvider);
  return service.getCapabilities();
});

/// Provider for listing AI modules
final aiModulesProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(aiServiceProvider);
  return service.getModules();
});

/// Provider for AI health status
final aiHealthProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(aiServiceProvider);
  return service.getHealth();
});

/// Provider for user AI usage stats
final aiUsageProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(aiServiceProvider);
  return service.getUsageStats();
});

/// Family provider for module tasks
final aiModuleTasksProvider = FutureProvider.family<List<AITask>, String>((ref, module) async {
  final service = ref.watch(aiServiceProvider);
  return service.getModuleTasks(module);
});
