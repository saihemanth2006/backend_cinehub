import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/paginated_result.dart';
import '../datasources/project_datasource.dart';
import '../models/project_models.dart';

/// Project repository — business-level data access.
///
/// Currently a thin pass-through, but designed for:
/// - Adding cache-first strategy
/// - Offline queue support
/// - Optimistic updates
class ProjectRepository {
  final ProjectDataSource _dataSource;

  ProjectRepository(this._dataSource);

  Future<Either<Failure, PaginatedResult<ProjectDto>>> listProjects(
    PaginationParams params,
  ) =>
      _dataSource.listProjects(params);

  Future<Either<Failure, PaginatedResult<ProjectDto>>> getMyProjects(
    PaginationParams params,
  ) =>
      _dataSource.getMyProjects(params);

  Future<Either<Failure, ProjectDto>> getProjectById(String id) =>
      _dataSource.getProjectById(id);

  Future<Either<Failure, ProjectDto>> getProjectBySlug(String slug) =>
      _dataSource.getProjectBySlug(slug);

  Future<Either<Failure, ProjectDto>> createProject(
    CreateProjectRequest request,
  ) =>
      _dataSource.createProject(request);

  Future<Either<Failure, ProjectDto>> updateProject(
    String id,
    UpdateProjectRequest request,
  ) =>
      _dataSource.updateProject(id, request);

  Future<Either<Failure, void>> deleteProject(String id) =>
      _dataSource.deleteProject(id);
}

// ── Riverpod Providers ──────────────────────────

final projectDataSourceProvider = Provider<ProjectDataSource>((ref) {
  return ProjectDataSource(ref.watch(apiClientProvider));
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository(ref.watch(projectDataSourceProvider));
});
