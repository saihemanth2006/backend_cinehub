import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Network connectivity monitor.
///
/// Provides a stream of connectivity status for:
/// - Showing offline banners
/// - Preventing API calls when offline
/// - Triggering sync when back online
class NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  /// Checks current connectivity status.
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  /// Stream of connectivity changes.
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map(
        (results) => !results.contains(ConnectivityResult.none),
      );
}

/// Riverpod provider for network info.
final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfo());

/// Stream provider for reactive connectivity status in UI.
final connectivityStreamProvider = StreamProvider<bool>((ref) {
  return ref.watch(networkInfoProvider).onConnectivityChanged;
});
