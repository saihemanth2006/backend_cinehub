import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import '../config/app_config.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';

/// Lightweight SocketService that connects to backend and exposes a
/// stream of realtime opportunity/job events.
class SocketService {
  final AppConfig config;
  final ApiClient? apiClient;
  IO.Socket? _socket;
  final _jobsController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final List<Map<String, dynamic>> _currentJobs = [];
  final _postsController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final List<Map<String, dynamic>> _currentPosts = [];

  SocketService({required this.config, this.apiClient}) {
    _init();
  }

  Stream<List<Map<String, dynamic>>> get jobsStream => _jobsController.stream;
  Stream<List<Map<String, dynamic>>> get postsStream => _postsController.stream;

  void _init() {
    try {
      final uri = config.apiBaseUrl;
      _socket = IO.io(uri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      _socket?.on('connect', (_) => debugPrint('Socket connected: \${_socket?.id}'));

      // Common event names that backend might emit for opportunities/jobs.
      _socket?.on('opportunities', _handlePayload);
      _socket?.on('opportunity', _handlePayload);
      _socket?.on('new_opportunity', _handlePayload);
      _socket?.on('new_job', _handlePayload);

      // Generic fallback if backend emits a list under 'jobs'
      _socket?.on('jobs', _handlePayload);
      // Feed / posts events
      _socket?.on('posts', _handlePostsPayload);
      _socket?.on('post', _handlePostsPayload);
      _socket?.on('new_post', _handlePostsPayload);

      // Listen for disconnects
      _socket?.on('disconnect', (_) => debugPrint('Socket disconnected'));

      // Fetch initial snapshot from REST API (if available) so UI has data
      _fetchInitialJobs();
      _fetchInitialPosts();
    } catch (e) {
      debugPrint('Socket init error: $e');
    }
  }

  Future<void> _fetchInitialJobs() async {
    if (apiClient == null) return;
    try {
      final resp = await apiClient!.dio.get('/opportunities');
      if (resp.statusCode == 200) {
        final data = resp.data is Map && resp.data['data'] != null ? resp.data['data'] : resp.data;
        if (data is List) {
          final list = data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
          _currentJobs
            ..clear()
            ..addAll(list);
          _jobsController.add(List.unmodifiable(_currentJobs));
        }
      }
    } on DioException catch (e) {
      debugPrint('Initial jobs fetch failed: ${e.message}');
    } catch (e) {
      debugPrint('Initial jobs fetch error: $e');
    }
  }

  Future<void> _fetchInitialPosts() async {
    if (apiClient == null) return;
    try {
      final resp = await apiClient!.dio.get('/api/feed?page=1&limit=30');
      if (resp.statusCode == 200) {
        final data = resp.data is Map && resp.data['posts'] != null ? resp.data['posts'] : resp.data;
        if (data is List) {
          final list = data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
          _currentPosts
            ..clear()
            ..addAll(list);
          _postsController.add(List.unmodifiable(_currentPosts));
        }
      }
    } on DioException catch (e) {
      debugPrint('Initial posts fetch failed: ${e.message}');
    } catch (e) {
      debugPrint('Initial posts fetch error: $e');
    }
  }

  void _handlePayload(dynamic payload) {
    try {
      if (payload == null) return;
      // If payload is a list (of maps)
      if (payload is List) {
        final list = payload.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
        _currentJobs
          ..clear()
          ..addAll(list);
        _jobsController.add(List.unmodifiable(_currentJobs));
        return;
      }

      // If payload is a single object, append/merge into current list
      if (payload is Map) {
        final item = Map<String, dynamic>.from(payload);
        // prepend new item
        _currentJobs.insert(0, item);
        _jobsController.add(List.unmodifiable(_currentJobs));
        return;
      }

      // If payload is a JSON-string, try to decode
      if (payload is String) {
        // ignore: avoid_dynamic_calls
        try {
          // naive parsing; backend typically sends objects not raw JSON here
          // leave as no-op if parsing not available
        } catch (_) {}
      }
    } catch (e) {
      debugPrint('Socket payload handling error: $e');
    }
  }

  void _handlePostsPayload(dynamic payload) {
    try {
      if (payload == null) return;
      if (payload is List) {
        final list = payload.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
        _currentPosts
          ..clear()
          ..addAll(list);
        _postsController.add(List.unmodifiable(_currentPosts));
        return;
      }

      if (payload is Map) {
        final item = Map<String, dynamic>.from(payload);
        _currentPosts.insert(0, item);
        _postsController.add(List.unmodifiable(_currentPosts));
        return;
      }
    } catch (e) {
      debugPrint('Socket posts payload handling error: $e');
    }
  }

  void dispose() {
    try {
      _socket?.dispose();
    } catch (_) {}
    _jobsController.close();
  }
}
