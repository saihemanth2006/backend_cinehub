import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/paginated_result.dart';
import '../../../auth/data/models/auth_models.dart';

/// User profile data source — profile updates, follow/unfollow.
class UserDataSource extends BaseApiService {
  UserDataSource(ApiClient client) : super(client);

  Future<Either<Failure, UserDto>> getUserById(String id) {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.userById(id));
      return extractData(response, UserDto.fromJson);
    });
  }

  Future<Either<Failure, UserDto>> updateProfile(
    UpdateProfileRequest request,
  ) {
    return safeRequest(() async {
      final response = await patch(
        ApiEndpoints.updateProfile,
        data: request.toJson(),
      );
      return extractData(response, UserDto.fromJson);
    });
  }

  Future<Either<Failure, PaginatedResult<UserDto>>> listUsers(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.users,
        queryParameters: params.toQueryParams(),
      );
      return PaginatedResult(
        items: extractList(response, UserDto.fromJson),
        pagination: extractPagination(response) ??
            PaginatedResult.empty<UserDto>().pagination,
      );
    });
  }

  Future<Either<Failure, void>> followUser(String userId) {
    return safeRequest(() async {
      await post(ApiEndpoints.followUser(userId));
    });
  }

  Future<Either<Failure, void>> unfollowUser(String userId) {
    return safeRequest(() async {
      await delete(ApiEndpoints.followUser(userId));
    });
  }

  Future<Either<Failure, PaginatedResult<UserDto>>> getFollowers(
    String userId,
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.userFollowers(userId),
        queryParameters: params.toQueryParams(),
      );
      return PaginatedResult(
        items: extractList(response, UserDto.fromJson),
        pagination: extractPagination(response) ??
            PaginatedResult.empty<UserDto>().pagination,
      );
    });
  }

  Future<Either<Failure, PaginatedResult<UserDto>>> getFollowing(
    String userId,
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.userFollowing(userId),
        queryParameters: params.toQueryParams(),
      );
      return PaginatedResult(
        items: extractList(response, UserDto.fromJson),
        pagination: extractPagination(response) ??
            PaginatedResult.empty<UserDto>().pagination,
      );
    });
  }
}

// ── Providers ───────────────────────────────────

final userDataSourceProvider = Provider<UserDataSource>((ref) {
  return UserDataSource(ref.watch(apiClientProvider));
});
