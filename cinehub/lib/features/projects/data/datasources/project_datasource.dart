import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/paginated_result.dart';
import '../models/project_models.dart';

/// Project data source — all project HTTP operations.
class ProjectDataSource extends BaseApiService {
  ProjectDataSource(ApiClient client) : super(client);

  /// List public projects with optional filters.
  Future<Either<Failure, PaginatedResult<ProjectDto>>> listProjects(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.projects,
        queryParameters: params.toQueryParams(),
      );
      final items = extractList(response, ProjectDto.fromJson);
      final pagination = extractPagination(response);
      return PaginatedResult(
        items: items,
        pagination: pagination ?? PaginatedResult.empty<ProjectDto>().pagination,
      );
    });
  }

  /// Get projects owned by current user.
  Future<Either<Failure, PaginatedResult<ProjectDto>>> getMyProjects(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.myProjects,
        queryParameters: params.toQueryParams(),
      );
      final items = extractList(response, ProjectDto.fromJson);
      final pagination = extractPagination(response);
      return PaginatedResult(
        items: items,
        pagination: pagination ?? PaginatedResult.empty<ProjectDto>().pagination,
      );
    });
  }

  /// Get a single project by ID.
  Future<Either<Failure, ProjectDto>> getProjectById(String id) {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.projectById(id));
      return extractData(response, ProjectDto.fromJson);
    });
  }

  /// Get a single project by slug.
  Future<Either<Failure, ProjectDto>> getProjectBySlug(String slug) {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.projectBySlug(slug));
      return extractData(response, ProjectDto.fromJson);
    });
  }

  /// Create a new project.
  Future<Either<Failure, ProjectDto>> createProject(
    CreateProjectRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.projects,
        data: request.toJson(),
      );
      return extractData(response, ProjectDto.fromJson);
    });
  }

  /// Update an existing project.
  Future<Either<Failure, ProjectDto>> updateProject(
    String id,
    UpdateProjectRequest request,
  ) {
    return safeRequest(() async {
      final response = await patch(
        ApiEndpoints.projectById(id),
        data: request.toJson(),
      );
      return extractData(response, ProjectDto.fromJson);
    });
  }

  /// Soft-delete a project.
  Future<Either<Failure, void>> deleteProject(String id) {
    return safeRequest(() async {
      await delete(ApiEndpoints.projectById(id));
    });
  }
}
