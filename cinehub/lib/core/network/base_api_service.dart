import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class BaseApiService {
  /// Build a full URI from a path which may start with or without a leading '/'
  static Uri _buildUri(String path, [Map<String, String>? queryParameters]) {
    final base = AppConfig.apiBaseUrl;
    final normalized = path.startsWith('/') ? path : '/$path';
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return Uri.parse('$base$normalized').replace(queryParameters: queryParameters);
    }
    return Uri.parse('$base$normalized');
  }

  static Map<String, String> _defaultHeaders([String? token]) {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  static Future<http.Response> get(String path, {Map<String, String>? queryParameters, String? token}) {
    final uri = _buildUri(path, queryParameters);
    return http.get(uri, headers: _defaultHeaders(token));
  }

  static Future<http.Response> post(String path, {Object? body, String? token}) {
    final uri = _buildUri(path);
    return http.post(uri, headers: _defaultHeaders(token), body: body is String ? body : jsonEncode(body ?? {}));
  }

  static Future<http.Response> delete(String path, {Object? body, String? token}) {
    final uri = _buildUri(path);
    return http.delete(uri, headers: _defaultHeaders(token), body: body is String ? body : jsonEncode(body ?? {}));
  }

  /// Multipart upload helper returns the server response. Caller handles parsing.
  static Future<http.StreamedResponse> multipart(String path, http.MultipartRequest request, {String? token}) async {
    final uri = _buildUri(path);
    request.headers.addAll(_defaultHeaders(token));
    // Ensure caller created the MultipartRequest with the correct URL.
    // `http.MultipartRequest.url` has no setter; do not attempt to assign it.
    return request.send();
  }
}
