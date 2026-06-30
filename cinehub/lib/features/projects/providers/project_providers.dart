import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/paginated_result.dart';
import '../data/models/project_models.dart';
import '../data/repositories/project_repository.dart';

part 'project_providers.freezed.dart';

// ── Projects List State ─────────────────────────

@freezed
class ProjectsListState with _$ProjectsListState {
  const factory ProjectsListState({
    @Default([]) List<ProjectDto> projects,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    String? errorMessage,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
  }) = _ProjectsListState;
}

// ── Projects List Notifier (infinite scroll) ────

class ProjectsListNotifier extends StateNotifier<ProjectsListState> {
  final ProjectRepository _repository;

  ProjectsListNotifier(this._repository) : super(const ProjectsListState());

  /// Initial load.
  Future<void> loadProjects({
    String? search,
    String? type,
    String? genre,
  }) async {
    state = state.copyWith(isLoading: true, hasError: false, errorMessage: null);

    final params = PaginationParams(
      page: 1,
      limit: 20,
      search: search,
      filters: {
        if (type != null) 'type': type,
        if (genre != null) 'genre': genre,
      },
    );

    final result = await _repository.listProjects(params);
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: failure.message,
      ),
      (paginated) => state.copyWith(
        isLoading: false,
        projects: paginated.items,
        hasMore: paginated.hasMore,
        currentPage: 1,
      ),
    );
  }

  /// Load next page (infinite scroll).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final params = PaginationParams(
      page: state.currentPage + 1,
      limit: 20,
    );

    final result = await _repository.listProjects(params);
    state = result.fold(
      (failure) => state.copyWith(isLoadingMore: false),
      (paginated) => state.copyWith(
        isLoadingMore: false,
        projects: [...state.projects, ...paginated.items],
        hasMore: paginated.hasMore,
        currentPage: state.currentPage + 1,
      ),
    );
  }

  /// Refresh (pull-to-refresh).
  Future<void> refresh() async {
    state = const ProjectsListState();
    await loadProjects();
  }
}

// ── Single Project State ────────────────────────

@freezed
class ProjectDetailState with _$ProjectDetailState {
  const factory ProjectDetailState.initial() = _PDInitial;
  const factory ProjectDetailState.loading() = _PDLoading;
  const factory ProjectDetailState.loaded(ProjectDto project) = _PDLoaded;
  const factory ProjectDetailState.error(String message) = _PDError;
}

class ProjectDetailNotifier extends StateNotifier<ProjectDetailState> {
  final ProjectRepository _repository;

  ProjectDetailNotifier(this._repository)
      : super(const ProjectDetailState.initial());

  Future<void> loadProject(String id) async {
    state = const ProjectDetailState.loading();
    final result = await _repository.getProjectById(id);
    state = result.fold(
      (failure) => ProjectDetailState.error(failure.message),
      (project) => ProjectDetailState.loaded(project),
    );
  }
}

// ── Providers ───────────────────────────────────

final projectsListProvider =
    StateNotifierProvider<ProjectsListNotifier, ProjectsListState>((ref) {
  return ProjectsListNotifier(ref.watch(projectRepositoryProvider));
});

final projectDetailProvider = StateNotifierProvider.family<
    ProjectDetailNotifier, ProjectDetailState, String>((ref, projectId) {
  return ProjectDetailNotifier(ref.watch(projectRepositoryProvider))
    ..loadProject(projectId);
});

/// My projects provider (separate state from public listing).
final myProjectsProvider =
    StateNotifierProvider<ProjectsListNotifier, ProjectsListState>((ref) {
  final notifier = ProjectsListNotifier(ref.watch(projectRepositoryProvider));
  // Auto-load on creation
  Future.microtask(() => notifier.loadProjects());
  return notifier;
});
