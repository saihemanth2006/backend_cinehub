import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/paginated_result.dart';

/// Media upload data source — file upload with progress tracking.
class MediaDataSource extends BaseApiService {
  MediaDataSource(ApiClient client) : super(client);

  /// Upload a media file with progress callback.
  Future<Either<Failure, Map<String, dynamic>>> uploadMedia({
    required String filePath,
    required String fileName,
    String? projectId,
    List<String>? tags,
    void Function(double progress)? onProgress,
  }) {
    return safeRequest(() async {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
        if (projectId != null) 'projectId': projectId,
        if (tags != null) 'tags': tags.join(','),
      });

      final response = await upload(
        ApiEndpoints.mediaUpload,
        formData: formData,
        onSendProgress: (sent, total) {
          if (onProgress != null && total > 0) {
            onProgress(sent / total);
          }
        },
      );

      final body = response.data as Map<String, dynamic>;
      return body['data'] as Map<String, dynamic>;
    });
  }

  Future<Either<Failure, PaginatedResult<Map<String, dynamic>>>> getMyMedia(
    PaginationParams params,
  ) {
    return safeRequest(() async {
      final response = await get(
        ApiEndpoints.myMedia,
        queryParameters: params.toQueryParams(),
      );
      final body = response.data as Map<String, dynamic>;
      final items = (body['data'] as List).cast<Map<String, dynamic>>();
      final pagination = extractPagination(response);
      return PaginatedResult(
        items: items,
        pagination:
            pagination ?? PaginatedResult.empty<Map<String, dynamic>>().pagination,
      );
    });
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getStorageUsage() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.storageUsage);
      final body = response.data as Map<String, dynamic>;
      return (body['data'] as List).cast<Map<String, dynamic>>();
    });
  }

  Future<Either<Failure, void>> deleteMedia(String id) {
    return safeRequest(() async {
      await delete(ApiEndpoints.mediaById(id));
    });
  }
}

// ── Providers ───────────────────────────────────

final mediaDataSourceProvider = Provider<MediaDataSource>((ref) {
  return MediaDataSource(ref.watch(apiClientProvider));
});
