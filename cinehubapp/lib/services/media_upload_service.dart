import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class MediaUploadService {
  static const allowedImageMimes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
  static const allowedVideoMimes = ['video/mp4', 'video/quicktime', 'video/x-msvideo', 'video/webm'];
  static const maxFileSize = 50 * 1024 * 1024; // 50MB

  static Future<FilePickerResult?> pickMedia({bool onlyImages = false}) async {
    try {
      return await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: onlyImages
            ? ['jpg', 'jpeg', 'png', 'gif', 'webp']
            : ['jpg', 'jpeg', 'png', 'gif', 'webp', 'mp4', 'mov', 'avi', 'webm'],
        allowMultiple: false,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<String?> uploadMedia(String baseUrl, String token, String filePath, String filename) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();

      if (bytes.length > maxFileSize) {
        throw Exception('File too large. Maximum size: 50MB');
      }

      final base64File = base64Encode(bytes);
      final mimeType = _getMimeType(filename);

      final uri = Uri.parse('$baseUrl/api/upload');
      final body = jsonEncode({
        'file': base64File,
        'filename': filename,
        'mimetype': mimeType,
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
      throw Exception('Upload error: $e');
    }
  }

  static String _getMimeType(String filename) {
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
    return mimeTypes[ext] ?? 'application/octet-stream';
  }

  static bool isVideo(String url) {
    return url.toLowerCase().endsWith('.mp4') ||
        url.toLowerCase().endsWith('.mov') ||
        url.toLowerCase().endsWith('.avi') ||
        url.toLowerCase().endsWith('.webm');
  }

  static bool isImage(String url) {
    return url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg') ||
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.gif') ||
        url.toLowerCase().endsWith('.webp');
  }
}
