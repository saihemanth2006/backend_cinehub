import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

class AppConfig {
  // Production Vercel URL
  static const String _productionUrl = 'https://backend-cinehub.vercel.app';
  
  static String get apiBaseUrl {
    // 1. Allow manual override via command line
    const env = String.fromEnvironment('API_BASE_URL', defaultValue: '');
    if (env.isNotEmpty) return env;

    // 2. Web always uses localhost
    if (kIsWeb) {
      return 'http://localhost:4000';
    }

    // 3. Desktop platforms (Windows, macOS, Linux) use localhost
    if (defaultTargetPlatform == TargetPlatform.windows || 
        defaultTargetPlatform == TargetPlatform.macOS || 
        defaultTargetPlatform == TargetPlatform.linux) {
      return 'http://localhost:4000';
    }

    // 4. External mobile devices (Android, iOS, Fuchsia) use the deployed backend
    return _productionUrl;
  }
}
