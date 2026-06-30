import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';
import 'api_response.dart';

/// Paginated result container used across all list endpoints.
///
/// Wraps a list of items with pagination metadata from the backend.
class PaginatedResult<T> {
  final List<T> items;
  final PaginationMeta pagination;

  const PaginatedResult({
    required this.items,
    required this.pagination,
  });

  bool get hasMore => pagination.hasNextPage;
  int get nextPage => pagination.nextPage ?? pagination.page + 1;
  int get totalItems => pagination.totalDocs;

  /// Creates an empty result for initial/loading states.
  factory PaginatedResult.empty() => PaginatedResult(
        items: const [],
        pagination: const PaginationMeta(
          totalDocs: 0,
          totalPages: 0,
          page: 1,
          limit: 20,
          hasNextPage: false,
          hasPrevPage: false,
        ),
      );

  /// Merges new page results into existing (for infinite scroll).
  PaginatedResult<T> merge(PaginatedResult<T> next) {
    return PaginatedResult(
      items: [...items, ...next.items],
      pagination: next.pagination,
    );
  }
}

/// Type alias for paginated Either results.
typedef PaginatedEither<T> = Future<Either<Failure, PaginatedResult<T>>>;

/// Standard query parameters for paginated list endpoints.
class PaginationParams {
  final int page;
  final int limit;
  final String? sortBy;
  final String? search;
  final Map<String, dynamic> filters;

  const PaginationParams({
    this.page = 1,
    this.limit = 20,
    this.sortBy,
    this.search,
    this.filters = const {},
  });

  PaginationParams copyWith({
    int? page,
    int? limit,
    String? sortBy,
    String? search,
    Map<String, dynamic>? filters,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      sortBy: sortBy ?? this.sortBy,
      search: search ?? this.search,
      filters: filters ?? this.filters,
    );
  }

  /// Converts to query parameters map for Dio.
  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'limit': limit,
      if (sortBy != null) 'sortBy': sortBy,
      if (search != null && search!.isNotEmpty) 'search': search,
      ...filters,
    };
  }

  PaginationParams nextPage() => copyWith(page: page + 1);
}
