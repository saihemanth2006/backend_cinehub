import '../core/network/base_api_service.dart';
import 'dart:convert';
import '../core/config/app_config.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? token;
  Map<String, dynamic>? user;

  String get _baseUrl => AppConfig.apiBaseUrl;

  void setFromLogin(dynamic body) {
    if (body == null) return;
    try {
      final tokenVal = body['token'];
      if (tokenVal is String) token = tokenVal;
      final u = body['user'];
      if (u is Map) {
        user = Map<String, dynamic>.from(u.cast<String, dynamic>());
      }
    } catch (e) {
      // ignore malformed body
    }
  }

  Future<Map<String, dynamic>?> fetchMe() async {
    if (token == null) return null;
    try {
      final resp = await BaseApiService.get('/me', token: token);
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        if (body is Map && body['ok'] == true) {
          final u = body['user'];
          if (u is Map<String, dynamic>) user = u;
          return user;
        }
        throw Exception('Unexpected response from /me');
      }
      throw Exception('Failed to fetch /me: ${resp.statusCode}');
    } catch (e) {
      // bubble up to caller
      rethrow;
    }
    return null;
  }

  /// Call backend /logout to revoke token, then clear local auth state.
  Future<bool> logout() async {
    if (token == null) {
      clear();
      return true;
    }
    try {
      final resp = await BaseApiService.post('/logout', token: token);
      clear();
      return resp.statusCode == 200;
    } catch (e) {
      clear();
      return false;
    }
  }

  /// Clear local token and user info
  void clear() {
    token = null;
    user = null;
  }

  // Social actions
  Future<bool> follow(String toId) async {
    if (token == null) return false;
    try {
      final resp = await BaseApiService.post('/api/follow', body: {'to': toId}, token: token);
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unfollow(String toId) async {
    if (token == null) return false;
    try {
      final resp = await BaseApiService.post('/api/unfollow', body: {'to': toId}, token: token);
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> likePost(String postId) async {
    if (token == null) return false;
    try {
      final resp = await BaseApiService.post('/api/posts/$postId/like', token: token);
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unlikePost(String postId) async {
    if (token == null) return false;
    try {
      final resp = await BaseApiService.delete('/api/posts/$postId/like', token: token);
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Fetch feed posts from backend. Returns list of post maps or empty list.
  Future<List<Map<String, dynamic>>> fetchFeed({int page = 1, int limit = 20}) async {
    try {
      final resp = await BaseApiService.get('/api/feed', queryParameters: {'page': page.toString(), 'limit': limit.toString()}, token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['posts'];
          if (list is List) {
            return List<Map<String, dynamic>>.from(list.map((e) {
              if (e is Map) return Map<String, dynamic>.from(e.cast<String, dynamic>());
              return <String, dynamic>{};
            }));
          }
        }
        throw Exception('Malformed feed response');
      }
      throw Exception('Failed to fetch feed: ${resp.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchUserStats(String userId) async {
    if (userId.isEmpty) return null;
    try {
      final resp = await BaseApiService.get('/api/users/$userId/stats', token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) return parsed as Map<String, dynamic>;
        throw Exception('Malformed user stats');
      }
      throw Exception('Failed to fetch user stats: ${resp.statusCode}');
    } catch (_) {}
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchFollowers(String userId) async {
    try {
      final resp = await BaseApiService.get('/api/users/$userId/followers', token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['followers'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
        throw Exception('Malformed followers response');
      }
      throw Exception('Failed to fetch followers: ${resp.statusCode}');
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  /// Fetch all users (basic public info)
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      final resp = await BaseApiService.get('/api/users', token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['users'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
        throw Exception('Malformed users response');
      }
      throw Exception('Failed to fetch users: ${resp.statusCode}');
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> fetchFollowing(String userId) async {
    try {
      final resp = await BaseApiService.get('/api/users/$userId/following', token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['following'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
        throw Exception('Malformed following response');
      }
      throw Exception('Failed to fetch following: ${resp.statusCode}');
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  /// Create a new post. Returns parsed post map on success, otherwise null.
  Future<Map<String, dynamic>?> createPost(String content, {List<String>? media}) async {
    if (token == null) return null;
    try {
      final resp = await BaseApiService.post('/api/posts', body: {'content': content, 'media': media ?? []}, token: token);
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) return parsed['post'] as Map<String, dynamic>?;
        throw Exception(parsed is Map && parsed['error'] != null ? parsed['error'].toString() : 'unknown_response');
      } else {
        try {
          final parsed = jsonDecode(resp.body);
          final msg = parsed is Map && parsed['error'] != null ? parsed['error'].toString() : 'status_${resp.statusCode}';
          throw Exception(msg);
        } catch (e) {
          throw Exception('status_${resp.statusCode}');
        }
      }
    } catch (e) {
      // bubble up exception for UI to show detailed message
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchCollabRequests() async {
    try {
      final resp = await BaseApiService.get('/api/collab-requests', token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['requests'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
      }
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  Future<Map<String, dynamic>?> createCollabRequest({required String role, List<String>? skills, String? location, String? type}) async {
    if (token == null) return null;
    try {
      final body = {
        'role': role,
        if (skills != null) 'skills': skills,
        if (location != null) 'location': location,
        if (type != null) 'type': type,
      };
      final resp = await BaseApiService.post('/api/collab-requests', body: body, token: token);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) return parsed['request'] as Map<String, dynamic>?;
      }
    } catch (_) {}
    return null;
  }
}
