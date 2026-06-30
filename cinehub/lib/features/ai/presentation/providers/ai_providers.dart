import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/ai_generate_service.dart';

// ═══════════════════════════════════════════════════════════
// ═  AI GENERATION STATE
// ═══════════════════════════════════════════════════════════

/// Represents the state of an AI generation request.
class AiGenerationState {
  final bool isLoading;
  final AiGenerateResponse? response;
  final String? error;
  final String? activeModule;
  final String? activeTask;

  const AiGenerationState({
    this.isLoading = false,
    this.response,
    this.error,
    this.activeModule,
    this.activeTask,
  });

  AiGenerationState copyWith({
    bool? isLoading,
    AiGenerateResponse? response,
    String? error,
    String? activeModule,
    String? activeTask,
  }) {
    return AiGenerationState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
      error: error,
      activeModule: activeModule ?? this.activeModule,
      activeTask: activeTask ?? this.activeTask,
    );
  }

  bool get hasResult => response != null;
  bool get hasError => error != null;
}

// ═══════════════════════════════════════════════════════════
// ═  AI GENERATION NOTIFIER
// ═══════════════════════════════════════════════════════════

/// Manages AI generation state for any module/task combination.
class AiGenerationNotifier extends StateNotifier<AiGenerationState> {
  final AiGenerateService _service;

  AiGenerationNotifier(this._service) : super(const AiGenerationState());

  /// Generate AI content using the unified endpoint.
  Future<void> generate({
    required String module,
    required String task,
    required dynamic input,
    Map<String, dynamic> options = const {},
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      activeModule: module,
      activeTask: task,
    );

    final result = await _service.generate(
      module: module,
      task: task,
      input: input,
      options: options,
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (response) => state = state.copyWith(
        isLoading: false,
        response: response,
      ),
    );
  }

  /// Clear current results.
  void clear() {
    state = const AiGenerationState();
  }
}

// ═══════════════════════════════════════════════════════════
// ═  AI CAPABILITIES STATE
// ═══════════════════════════════════════════════════════════

class AiCapabilitiesState {
  final bool isLoading;
  final List<AiModuleInfo>? capabilities;
  final String? error;

  const AiCapabilitiesState({
    this.isLoading = false,
    this.capabilities,
    this.error,
  });
}

class AiCapabilitiesNotifier extends StateNotifier<AiCapabilitiesState> {
  final AiGenerateService _service;

  AiCapabilitiesNotifier(this._service) : super(const AiCapabilitiesState());

  Future<void> load() async {
    state = const AiCapabilitiesState(isLoading: true);

    final result = await _service.getCapabilities();

    result.fold(
      (failure) => state = AiCapabilitiesState(error: failure.message),
      (capabilities) => state = AiCapabilitiesState(capabilities: capabilities),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ═  GENERATION HISTORY (in-memory for current session)
// ═══════════════════════════════════════════════════════════

class AiHistoryEntry {
  final String module;
  final String task;
  final dynamic input;
  final AiGenerateResponse response;
  final DateTime timestamp;

  const AiHistoryEntry({
    required this.module,
    required this.task,
    required this.input,
    required this.response,
    required this.timestamp,
  });
}

class AiHistoryNotifier extends StateNotifier<List<AiHistoryEntry>> {
  AiHistoryNotifier() : super([]);

  void add(AiHistoryEntry entry) {
    state = [entry, ...state].take(50).toList();
  }

  void clear() {
    state = [];
  }
}

// ═══════════════════════════════════════════════════════════
// ═  PROVIDERS
// ═══════════════════════════════════════════════════════════

final aiGenerationProvider =
    StateNotifierProvider<AiGenerationNotifier, AiGenerationState>((ref) {
  return AiGenerationNotifier(ref.watch(aiGenerateServiceProvider));
});

final aiCapabilitiesProvider =
    StateNotifierProvider<AiCapabilitiesNotifier, AiCapabilitiesState>((ref) {
  return AiCapabilitiesNotifier(ref.watch(aiGenerateServiceProvider));
});

final aiHistoryProvider =
    StateNotifierProvider<AiHistoryNotifier, List<AiHistoryEntry>>((ref) {
  return AiHistoryNotifier();
});
