import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform, File;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? token;
  Map<String, dynamic>? user;

  String get baseUrl {
    return 'https://backend-cinehub.vercel.app';
  }

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
      final uri = Uri.parse('$baseUrl/me');
      final resp = await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        if (body is Map && body['ok'] == true) {
          final u = body['user'];
          if (u is Map<String, dynamic>) user = u;
          return user;
        }
      }
    } catch (e) {
      // ignore network errors here
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
      final uri = Uri.parse('$baseUrl/logout');
      final resp = await http.post(uri, headers: {'Authorization': 'Bearer $token'});
      // regardless of server response, clear local state to log out immediately
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
      final uri = Uri.parse('$baseUrl/api/follow');
      final resp = await http.post(uri, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode({'to': toId}));
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unfollow(String toId) async {
    if (token == null) return false;
    try {
      final uri = Uri.parse('$baseUrl/api/unfollow');
      final resp = await http.post(uri, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode({'to': toId}));
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> likePost(String postId) async {
    if (token == null) return false;
    try {
      final uri = Uri.parse('$baseUrl/api/posts/$postId/like');
      final resp = await http.post(uri, headers: {'Authorization': 'Bearer $token'});
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unlikePost(String postId) async {
    if (token == null) return false;
    try {
      final uri = Uri.parse('$baseUrl/api/posts/$postId/like');
      final resp = await http.delete(uri, headers: {'Authorization': 'Bearer $token'});
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Fetch feed posts from backend. Returns list of post maps or empty list.
  Future<List<Map<String, dynamic>>> fetchFeed({int page = 1, int limit = 20}) async {
    try {
      final uri = Uri.parse('$baseUrl/api/feed?page=$page&limit=$limit');
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token != null) headers['Authorization'] = 'Bearer $token';
      final resp = await http.get(uri, headers: headers);
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
      }
    } catch (_) {}
    return <Map<String, dynamic>>[];
  }

  Future<Map<String, dynamic>?> fetchUserStats(String userId) async {
    if (userId.isEmpty) return null;
    try {
      final uri = Uri.parse('$baseUrl/api/users/$userId/stats');
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token != null) headers['Authorization'] = 'Bearer $token';
      final resp = await http.get(uri, headers: headers);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) return parsed as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchFollowers(String userId) async {
    try {
      final uri = Uri.parse('$baseUrl/api/users/$userId/followers');
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token != null) headers['Authorization'] = 'Bearer $token';
      final resp = await http.get(uri, headers: headers);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['followers'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
      }
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  /// Fetch all users (basic public info)
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      final uri = Uri.parse('$baseUrl/api/users');
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token != null) headers['Authorization'] = 'Bearer $token';
      final resp = await http.get(uri, headers: headers);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['users'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
      }
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> fetchFollowing(String userId) async {
    try {
      final uri = Uri.parse('$baseUrl/api/users/$userId/following');
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token != null) headers['Authorization'] = 'Bearer $token';
      final resp = await http.get(uri, headers: headers);
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          final list = parsed['following'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String,dynamic>>[];
        }
      }
    } catch (_) {}
    return <Map<String,dynamic>>[];
  }

  /// Create a new post. Returns parsed post map on success, otherwise null.
  Future<Map<String, dynamic>?> createPost(String content, {List<String>? media}) async {
    if (token == null) return null;
    try {
      final uri = Uri.parse('$baseUrl/api/posts');
      final body = jsonEncode({'content': content, 'media': media ?? []});
      final resp = await http.post(uri, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}, body: body);
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) return parsed['post'] as Map<String, dynamic>?;
        throw Exception(parsed is Map && parsed['error'] != null ? parsed['error'].toString() : 'unknown_response');
      } else {
        // try to parse error body
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

  /// Upload media file to backend and return the URL
  Future<String?> uploadMediaFile(String filePath, String filename) async {
    if (token == null) return null;
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final base64File = base64Encode(bytes);
      
      final ext = filename.toLowerCase().split('.').last;
      const mimeTypes = {
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
        'gif': 'image/gif',
        'webp': 'image/webp',
        'mp4': 'video/mp4',
        'mov': 'video/quicktime',
        'avi': 'video/x-msvideo',
        'webm': 'video/webm',
      };
      final mimetype = mimeTypes[ext] ?? 'application/octet-stream';

      final uri = Uri.parse('$baseUrl/api/upload');
      final body = jsonEncode({
        'file': base64File,
        'filename': filename,
        'mimetype': mimetype,
      });

      final resp = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true && parsed['url'] != null) {
          return parsed['url'].toString();
        }
      }

      throw Exception('Upload failed: ${resp.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}

