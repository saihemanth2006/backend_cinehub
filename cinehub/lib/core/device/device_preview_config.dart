import 'package:device_preview/device_preview.dart';

/// Curated Android-only device set for DevicePreview.
///
/// Includes flagship, mid-range, and budget Android phones
/// that represent the most common screen sizes in the market.
class DevicePreviewConfig {
  DevicePreviewConfig._();

  /// Default device to show on app start (Samsung Galaxy S20 equivalent).
  static final DeviceInfo defaultDevice = Devices.android.samsungGalaxyS20;

  /// Android-only device list for the device preview toolbar.
  static final List<DeviceInfo> androidDevices = [
    // ── Compact (360dp) ─────────────────────────────────────
    Devices.android.samsungGalaxyA50,

    // ── Standard (393–412dp) ────────────────────────────────
    Devices.android.samsungGalaxyS20,
    Devices.android.onePlus8Pro,
    Devices.android.sonyXperia1II,

    // ── Large / Foldable ────────────────────────────────────
    Devices.android.samsungGalaxyNote20,
    Devices.android.samsungGalaxyNote20Ultra,
  ];

  /// Storage key prefix for persisted settings.
  static const String storagePrefix = 'cinehub_device_preview';
}
