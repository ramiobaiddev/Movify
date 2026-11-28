import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

abstract interface class AppUpdateService {
  /// Checks Google Play for an available update.
  /// If an update is available:
  /// - When [immediate] is false (default): starts a flexible update (non-blocking).
  /// - When [immediate] is true: starts an immediate full-screen blocking update.
  Future<void> checkForUpdate({
    bool immediate = false,
    VoidCallback? onFlexibleUpdateDownloaded,
  });

  /// Installs the downloaded flexible update and restarts the app.
  Future<void> completeFlexibleUpdate();
}

class AppUpdateServiceImpl implements AppUpdateService {
  const AppUpdateServiceImpl();

  @override
  Future<void> checkForUpdate({
    bool immediate = false,
    VoidCallback? onFlexibleUpdateDownloaded,
  }) async {
    // In-App Update API is strictly Google Play on Android devices
    if (kIsWeb || !Platform.isAndroid) {
      debugPrint('ℹ️ [AppUpdateService] In-app updates only supported on Android.');
      return;
    }

    try {
      debugPrint('🔄 [AppUpdateService] Checking Google Play for updates...');
      final updateInfo = await InAppUpdate.checkForUpdate();

      debugPrint(
        '🔄 [AppUpdateService] Update availability: ${updateInfo.updateAvailability}, '
        'Immediate allowed: ${updateInfo.immediateUpdateAllowed}, '
        'Flexible allowed: ${updateInfo.flexibleUpdateAllowed}',
      );

      if (updateInfo.installStatus == InstallStatus.downloaded) {
        debugPrint('✅ [AppUpdateService] Update already downloaded. Prompting to complete...');
        if (onFlexibleUpdateDownloaded != null) {
          onFlexibleUpdateDownloaded();
        } else {
          await completeFlexibleUpdate();
        }
        return;
      }

      final isAvailable = updateInfo.updateAvailability ==
              UpdateAvailability.updateAvailable ||
          updateInfo.updateAvailability ==
              UpdateAvailability.developerTriggeredUpdateInProgress;

      if (isAvailable) {
        if (immediate && updateInfo.immediateUpdateAllowed) {
          debugPrint('🚀 [AppUpdateService] Starting Immediate update flow...');
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          debugPrint('🚀 [AppUpdateService] Starting Flexible update flow...');
          final result = await InAppUpdate.startFlexibleUpdate();
          debugPrint('📦 [AppUpdateService] Flexible update download result: $result');

          if (result == AppUpdateResult.success) {
            debugPrint('✅ [AppUpdateService] Flexible update downloaded.');
            if (onFlexibleUpdateDownloaded != null) {
              onFlexibleUpdateDownloaded();
            } else {
              // Default to completing the update
              await completeFlexibleUpdate();
            }
          }
        } else if (updateInfo.immediateUpdateAllowed) {
          // Fallback to immediate if flexible is not allowed
          debugPrint('🚀 [AppUpdateService] Flexible not allowed, falling back to Immediate...');
          await InAppUpdate.performImmediateUpdate();
        }
      }
    } catch (e, st) {
      debugPrint('⚠️ [AppUpdateService] In-app update check failed or not available: $e');
      if (kDebugMode) {
        debugPrint('$st');
      }
    }
  }

  @override
  Future<void> completeFlexibleUpdate() async {
    if (kIsWeb || !Platform.isAndroid) return;

    try {
      debugPrint('🔄 [AppUpdateService] Completing flexible update...');
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      debugPrint('❌ [AppUpdateService] Failed to complete flexible update: $e');
    }
  }
}
