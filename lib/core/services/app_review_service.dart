import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:movify/constant.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

abstract interface class AppReviewService {
  /// Opens the store listing directly on Google Play or App Store.
  /// Falls back to launching [Constants.appLinlk] in external browser if the store is unavailable.
  Future<void> openStoreListing();

  /// Requests the native in-app review dialog.
  /// Silently returns if the API is unavailable or quota is exhausted.
  Future<void> requestInAppReview();

  /// Records an app session open and prompts for review on key milestones
  /// (starting at 5 sessions, recurring every 10 sessions, with a 30-day cooldown).
  Future<void> recordAppOpenMilestone();

  /// Records an action milestone (e.g. adding favorites) and prompts on key milestones
  /// (starting at 3 favorites, recurring every 5 items, with a 30-day cooldown).
  Future<void> recordFavoriteMilestone();
}

class AppReviewServiceImpl implements AppReviewService {
  AppReviewServiceImpl({InAppReview? inAppReview, SharedPreferences? prefs})
    : _inAppReview = inAppReview ?? InAppReview.instance,
      _prefs = prefs;

  final InAppReview _inAppReview;
  SharedPreferences? _prefs;

  SharedPreferences get _preferences => _prefs ??= getIt<SharedPreferences>();

  static const String _appOpenCountKey = 'review_app_open_count';
  static const String _favoriteCountKey = 'review_favorite_count';
  static const String _lastPromptDateKey = 'review_last_prompt_date';
  static const int _minDaysBetweenPrompts = 30;

  @override
  Future<void> openStoreListing() async {
    debugPrint('⭐ [AppReviewService] openStoreListing() invoked.');
    try {
      if (await _inAppReview.isAvailable()) {
        debugPrint(
          '⭐ [AppReviewService] Opening native store listing via InAppReview...',
        );
        await _inAppReview.openStoreListing();
        return;
      }
    } catch (e) {
      debugPrint(
        '⚠️ [AppReviewService] InAppReview.openStoreListing failed: $e. Falling back to browser.',
      );
    }

    // Direct url_launcher fallback
    debugPrint(
      '⭐ [AppReviewService] Opening store link via url_launcher: ${Constants.appLinlk}',
    );
    final uri = Uri.parse(Constants.appLinlk);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Future<void> requestInAppReview() async {
    try {
      final available = await _inAppReview.isAvailable();
      debugPrint('⭐ [AppReviewService] InAppReview available: $available');
      if (available) {
        debugPrint(
          '⭐ [AppReviewService] Calling inAppReview.requestReview()...',
        );
        await _inAppReview.requestReview();
        debugPrint(
          '⭐ [AppReviewService] inAppReview.requestReview() call finished.',
        );
      } else {
        debugPrint(
          '⚠️ [AppReviewService] InAppReview is NOT available on this device/environment.',
        );
      }
    } catch (e, stack) {
      debugPrint(
        '❌ [AppReviewService] Error requesting in-app review: $e\n$stack',
      );
    }
  }

  @override
  Future<void> recordAppOpenMilestone() async {
    final count = (_preferences.getInt(_appOpenCountKey) ?? 0) + 1;
    await _preferences.setInt(_appOpenCountKey, count);
    debugPrint('⭐ [AppReviewService] App open count: $count');

    // Initial threshold: 5 sessions. Recurring cadence: every 10 sessions (5, 15, 25, 35...)
    if (count >= 5 && (count == 5 || count % 10 == 0)) {
      debugPrint(
        '⭐ [AppReviewService] Open milestone hit (count: $count)! Checking cooldown...',
      );
      await _checkAndRequestReview();
    }
  }

  @override
  Future<void> recordFavoriteMilestone() async {
    final count = (_preferences.getInt(_favoriteCountKey) ?? 0) + 1;
    await _preferences.setInt(_favoriteCountKey, count);
    debugPrint('⭐ [AppReviewService] Favorite count: $count');

    // Initial threshold: 3 favorites. Recurring cadence: every 5 items (3, 8, 13, 18...)
    if (count >= 3 && (count == 3 || count % 5 == 0)) {
      debugPrint(
        '⭐ [AppReviewService] Favorite milestone hit (count: $count)! Checking cooldown...',
      );
      await _checkAndRequestReview();
    }
  }

  Future<void> _checkAndRequestReview() async {
    final lastPromptMillis = _preferences.getInt(_lastPromptDateKey) ?? 0;
    if (lastPromptMillis > 0) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final daysSince = (now - lastPromptMillis) ~/ (1000 * 60 * 60 * 24);
      debugPrint(
        '⭐ [AppReviewService] Days since last prompt: $daysSince (min required: $_minDaysBetweenPrompts)',
      );
      if (daysSince < _minDaysBetweenPrompts) {
        debugPrint('⏳ [AppReviewService] Cooldown active. Skipping prompt.');
        return;
      }
    }

    await _preferences.setInt(
      _lastPromptDateKey,
      DateTime.now().millisecondsSinceEpoch,
    );
    debugPrint('🚀 [AppReviewService] Prompting review now!');
    await requestInAppReview();
  }
}
