import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/services/app_review_service.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/auth/presentation/cubits/session_state.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/domain/use_cases/add_favorite_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/get_favorite_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/merge_guest_favorites_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/pull_cloud_favorites_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/remove_favorite_use_case.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_state.dart';

/// Global favorites, local-first.
///
/// Every read comes from Hive. Firestore is a fire-and-forget backup that is
/// only read on explicit sign-in and on pull-to-refresh.
class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    required this.mergeGuestFavoritesUseCase,
    required this.pullCloudFavoritesUseCase,
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.sessionStream,
    required SessionState initialSessionState,
    AppReviewService? appReviewService,
  }) : _appReviewService = appReviewService,
       super(const FavoriteInitial()) {
    _sessionSub = sessionStream.listen(_onSessionChanged);
    _onSessionChanged(initialSessionState);
  }

  final MergeGuestFavoritesUseCase mergeGuestFavoritesUseCase;
  final PullCloudFavoritesUseCase pullCloudFavoritesUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final Stream<SessionState> sessionStream;
  final AppReviewService? _appReviewService;

  late final StreamSubscription<SessionState> _sessionSub;
  String _currentUserId = 'guest';
  bool _initialized = false;

  String get currentUserId => _currentUserId;

  Future<void> _onSessionChanged(SessionState session) async {
    if (session is SessionAuthenticated) {
      await _handleSignIn(
        userId: session.user.uid!,
        isExplicitSignIn: session.isExplicitSignIn,
      );
    } else if (session is SessionGuest) {
      _initialized = false;
      _currentUserId = 'guest';
      await loadFavorites();
    } else if (session is SessionUnauthenticated) {
      _initialized = false;
      _currentUserId = 'guest';
      if (!isClosed) {
        emit(const FavoriteInitial());
      }
    }
  }

  /// Merges guest favorites into the account on an explicit sign-in only, not
  /// on app restart. This is the only path that reads Firestore on its own.
  Future<void> _handleSignIn({
    required String userId,
    required bool isExplicitSignIn,
  }) async {
    if (_initialized && _currentUserId == userId) {
      return;
    }

    _initialized = true;
    _currentUserId = userId;

    if (isExplicitSignIn) {
      // A failed merge keeps the guest items in Hive; the next sign-in retries.
      await mergeGuestFavoritesUseCase(userId);
    }

    await loadFavorites();
  }

  /// Reads Hive. [showLoading] is false for refreshes so the list stays on
  /// screen instead of flashing a spinner.
  Future<void> loadFavorites({bool showLoading = true}) async {
    if (showLoading && !isClosed) {
      emit(const FavoriteLoading());
    }

    final result = await getFavoritesUseCase(
      userId: _currentUserId,
      // ignore: avoid_redundant_argument_values
      contentType: null,
    );

    if (isClosed) {
      return;
    }
    result.fold(
      (failure) => emit(FavoriteError(message: failure.errorMessage)),
      (items) => emit(
        FavoriteLoaded(items: items, currentUserId: _currentUserId),
      ),
    );
  }

  bool isFavorite(int specificId, ContentType contentType) {
    final current = state;
    return current is FavoriteLoaded &&
        current.contains(specificId, contentType);
  }

  /// Adds or removes [favorite]. The list updates first; the write follows and
  /// is rolled back if it fails.
  Future<void> toggleFavorite(FavoriteEntity favorite) async {
    final current = state;
    if (current is! FavoriteLoaded) {
      return;
    }

    final wasFavorite = current.contains(
      favorite.specificId,
      favorite.contentType,
    );
    final saved = favorite.copyWith(
      userId: _currentUserId,
      addedAt: DateTime.now(),
    );

    // A failed removal puts back the original, with its original date.
    final original = wasFavorite
        ? current.items.firstWhere(
            (f) =>
                f.specificId == favorite.specificId &&
                f.contentType == favorite.contentType,
          )
        : saved;

    emit(_withItem(current, saved, add: !wasFavorite));

    final result = wasFavorite
        ? await removeFavoriteUseCase(
            specificId: favorite.specificId,
            contentType: favorite.contentType,
            userId: _currentUserId,
          )
        : await addFavoriteUseCase(saved);

    // Undo only this item on the latest state, so a toggle made in the
    // meantime is not lost.
    result.fold(
      (_) {
        final latest = state;
        if (!isClosed && latest is FavoriteLoaded) {
          emit(_withItem(latest, original, add: wasFavorite));
        }
      },
      (_) {
        if (!wasFavorite) {
          _appReviewService?.recordFavoriteMilestone();
        }
      },
    );
  }

  FavoriteLoaded _withItem(
    FavoriteLoaded from,
    FavoriteEntity item, {
    required bool add,
  }) {
    final others = from.items
        .where(
          (f) =>
              f.specificId != item.specificId ||
              f.contentType != item.contentType,
        )
        .toList();
    return FavoriteLoaded(
      items: add ? [item, ...others] : others,
      currentUserId: from.currentUserId,
    );
  }

  /// Pull-to-refresh: re-reads the cloud copy for signed-in users.
  Future<void> refreshFromCloud() async {
    if (_currentUserId != 'guest') {
      // A failed pull keeps what is already in Hive.
      await pullCloudFavoritesUseCase(_currentUserId);
    }
    await loadFavorites(showLoading: false);
  }

  @override
  Future<void> close() {
    _sessionSub.cancel();
    return super.close();
  }
}
