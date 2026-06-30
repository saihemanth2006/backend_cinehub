import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/paginated_result.dart';
import '../models/portfolio_models.dart';

/// Portfolio data source with CRUD, likes, and discovery.
class PortfolioDataSource extends BaseApiService {
  PortfolioDataSource(ApiClient client) : super(client);

  Future<Either<Failure, PaginatedResult<PortfolioItemDto>>> getMyPortfolio(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.myPortfolio,
        queryParameters: params.toQueryParams(),
      );
      return PaginatedResult(
        items: extractList(response, PortfolioItemDto.fromJson),
        pagination: extractPagination(response) ??
            PaginatedResult.empty<PortfolioItemDto>().pagination,
      );
    });
  }

  Future<Either<Failure, PaginatedResult<PortfolioItemDto>>> getByUser(
    String userId,
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.portfolioByUser(userId),
        queryParameters: params.toQueryParams(),
      );
      return PaginatedResult(
        items: extractList(response, PortfolioItemDto.fromJson),
        pagination: extractPagination(response) ??
            PaginatedResult.empty<PortfolioItemDto>().pagination,
      );
    });
  }

  Future<Either<Failure, List<PortfolioItemDto>>> getTrending({
    int limit = 20,
  }) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.trendingPortfolios,
        queryParameters: {'limit': limit},
      );
      return extractList(response, PortfolioItemDto.fromJson);
    });
  }

  Future<Either<Failure, PortfolioItemDto>> getById(String id) {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.portfolioById(id));
      return extractData(response, PortfolioItemDto.fromJson);
    });
  }

  Future<Either<Failure, PortfolioItemDto>> create(
    CreatePortfolioRequest request,
  ) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.portfolios,
        data: request.toJson(),
      );
      return extractData(response, PortfolioItemDto.fromJson);
    });
  }

  Future<Either<Failure, int>> toggleLike(String id) {
    return safeRequest(() async {
      final response = await post(ApiEndpoints.likePortfolio(id));
      final body = response.data as Map<String, dynamic>;
      return (body['data'] as Map<String, dynamic>)['likeCount'] as int;
    });
  }

  Future<Either<Failure, void>> addComment(String id, String content) {
    return safeRequest(() async {
      await post(
        ApiEndpoints.portfolioComments(id),
        data: {'content': content},
      );
    });
  }

  Future<Either<Failure, void>> deleteItem(String id) {
    return safeRequest(() async {
      await delete(ApiEndpoints.portfolioById(id));
    });
  }
}

// ── Providers ───────────────────────────────────

final portfolioDataSourceProvider = Provider<PortfolioDataSource>((ref) {
  return PortfolioDataSource(ref.watch(apiClientProvider));
});
