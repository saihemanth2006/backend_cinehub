import 'dart:convert';
import '../core/network/base_api_service.dart';

class JobsService {
  Future<List<Map<String, dynamic>>> fetchJobs() async {
    try {
      final resp = await BaseApiService.get('/api/jobs');
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        if (body is Map && body['ok'] == true) {
          final list = body['jobs'] as List?;
          return list != null ? List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e))) : <Map<String, dynamic>>[];
        }
        throw Exception('Malformed jobs response');
      }
      throw Exception('Failed to fetch jobs: ${resp.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> postJob(Map<String, dynamic> payload, {String? token}) async {
    try {
      final resp = await BaseApiService.post('/api/jobs', body: payload, token: token);
      return resp.statusCode >= 200 && resp.statusCode < 300;
    } catch (e) {
      return false;
    }
  }
}
