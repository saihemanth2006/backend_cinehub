import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/paginated_result.dart';
import '../../../auth/data/models/auth_models.dart';

/// Discovery data source — creator search, suggestions, trending.
class DiscoveryDataSource extends BaseApiService {
  DiscoveryDataSource(ApiClient client) : super(client);

  Future<Either<Failure, PaginatedResult<UserDto>>> searchCreators(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.discoverCreators,
        queryParameters: params.toQueryParams(),
      );
      final items = extractList(response, UserDto.fromJson);
      final pagination = extractPagination(response);
      return PaginatedResult(
        items: items,
        pagination: pagination ?? PaginatedResult.empty<UserDto>().pagination,
      );
    });
  }

  Future<Either<Failure, List<UserDto>>> getTopCreators({int limit = 10}) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.topCreators,
        queryParameters: {'limit': limit},
      );
      return extractList(response, UserDto.fromJson);
    });
  }

  Future<Either<Failure, List<UserDto>>> getSuggestions() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.suggestions);
      return extractList(response, UserDto.fromJson);
    });
  }

  Future<Either<Failure, Map<String, dynamic>>> getTrending() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.trending);
      final body = response.data as Map<String, dynamic>;
      return body['data'] as Map<String, dynamic>;
    });
  }
}

// ── Providers ───────────────────────────────────

final discoveryDataSourceProvider = Provider<DiscoveryDataSource>((ref) {
  return DiscoveryDataSource(ref.watch(apiClientProvider));
});
