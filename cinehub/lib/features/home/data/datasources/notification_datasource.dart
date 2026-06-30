import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/paginated_result.dart';
import '../models/notification_models.dart';

/// Notification data source — list, read, mark, delete.
class NotificationDataSource extends BaseApiService {
  NotificationDataSource(ApiClient client) : super(client);

  Future<Either<Failure, PaginatedResult<NotificationDto>>> getNotifications(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.notifications,
        queryParameters: params.toQueryParams(),
      );
      return PaginatedResult(
        items: extractList(response, NotificationDto.fromJson),
        pagination: extractPagination(response) ??
            PaginatedResult.empty<NotificationDto>().pagination,
      );
    });
  }

  Future<Either<Failure, int>> getUnreadCount() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.unreadCount);
      final body = response.data as Map<String, dynamic>;
      final data = body['data'] as Map<String, dynamic>;
      return data['unreadCount'] as int;
    });
  }

  Future<Either<Failure, void>> markAsRead(String id) {
    return safeRequest(() async {
      await patch(ApiEndpoints.markRead(id));
    });
  }

  Future<Either<Failure, void>> markAllAsRead() {
    return safeRequest(() async {
      await patch(ApiEndpoints.markAllRead);
    });
  }

  Future<Either<Failure, void>> deleteNotification(String id) {
    return safeRequest(() async {
      await delete(ApiEndpoints.deleteNotification(id));
    });
  }
}

// ── Providers ───────────────────────────────────

final notificationDataSourceProvider = Provider<NotificationDataSource>((ref) {
  return NotificationDataSource(ref.watch(apiClientProvider));
});

/// Unread count provider — auto-refreshes on invalidation.
final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final ds = ref.watch(notificationDataSourceProvider);
  final result = await ds.getUnreadCount();
  return result.fold(
    (_) => 0,
    (count) => count,
  );
});
