// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/auth/domain/entities/user_entity.dart';
import 'package:movify/features/auth/presentation/cubits/session_state.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/domain/use_cases/add_favorite_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/get_favorite_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/merge_guest_favorites_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/pull_cloud_favorites_use_case.dart';
import 'package:movify/features/favorite/domain/use_cases/remove_favorite_use_case.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_cubit.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_state.dart';

class MockMergeGuestFavoritesUseCase extends Mock
    implements MergeGuestFavoritesUseCase {}

class MockPullCloudFavoritesUseCase extends Mock
    implements PullCloudFavoritesUseCase {}

class MockGetFavoritesUseCase extends Mock implements GetFavoritesUseCase {}

class MockAddFavoriteUseCase extends Mock implements AddFavoriteUseCase {}

class MockRemoveFavoriteUseCase extends Mock implements RemoveFavoriteUseCase {}

void main() {
  late MockMergeGuestFavoritesUseCase mockMergeUseCase;
  late MockPullCloudFavoritesUseCase mockPullCloudUseCase;
  late MockGetFavoritesUseCase mockGetFavoritesUseCase;
  late MockAddFavoriteUseCase mockAddFavoriteUseCase;
  late MockRemoveFavoriteUseCase mockRemoveFavoriteUseCase;
  late StreamController<SessionState> sessionStreamController;

  final testUser = UserEntity(
    uid: 'user_123',
    email: 'test@test.com',
    displayName: 'Test User',
    photoUrl: '',
    isEmailVerified: true,
    isGuest: false,
    createdAt: DateTime.now(),
  );

  final guestUser = UserEntity.guest();

  setUp(() {
    mockMergeUseCase = MockMergeGuestFavoritesUseCase();
    mockPullCloudUseCase = MockPullCloudFavoritesUseCase();
    mockGetFavoritesUseCase = MockGetFavoritesUseCase();
    mockAddFavoriteUseCase = MockAddFavoriteUseCase();
    mockRemoveFavoriteUseCase = MockRemoveFavoriteUseCase();
    sessionStreamController = StreamController<SessionState>.broadcast();

    // Default mock behaviors
    when(
      () => mockMergeUseCase(any()),
    ).thenAnswer((_) async => const Right(unit));
    when(
      () => mockGetFavoritesUseCase(
        userId: any(named: 'userId'),
        contentType: any(named: 'contentType'),
      ),
    ).thenAnswer((_) async => const Right(<FavoriteEntity>[]));
  });

  tearDown(() {
    sessionStreamController.close();
  });

  FavoriteCubit buildCubit(SessionState initialState) => FavoriteCubit(
    mergeGuestFavoritesUseCase: mockMergeUseCase,
    pullCloudFavoritesUseCase: mockPullCloudUseCase,
    getFavoritesUseCase: mockGetFavoritesUseCase,
    addFavoriteUseCase: mockAddFavoriteUseCase,
    removeFavoriteUseCase: mockRemoveFavoriteUseCase,
    sessionStream: sessionStreamController.stream,
    initialSessionState: initialState,
  );

  group('FavoriteCubit - Authentication Flow', () {
    blocTest<FavoriteCubit, FavoriteState>(
      'starts as guest, then merges cloud data when user signs in',
      build: () => buildCubit(SessionGuest(user: guestUser)),
      act: (cubit) async {
        // Wait for initial constructor events to settle
        await Future.delayed(Duration.zero);
        // Simulate user successfully logging in explicitly
        sessionStreamController.add(SessionAuthenticated(user: testUser, isExplicitSignIn: true));
      },
      skip: 1, // Skips the async Loaded from the initial guest state
      expect: () => [isA<FavoriteLoading>(), isA<FavoriteLoaded>()],
      verify: (cubit) {
        // 1. Verify it merged guest favorites since it was the first sign-in
        verify(() => mockMergeUseCase(testUser.uid!)).called(1);

        // 2. Verify it fetched from Hive using the real user ID
        verify(
          () => mockGetFavoritesUseCase(userId: testUser.uid!),
        ).called(greaterThan(0));

        // 3. Verify internal state ID is updated
        expect(cubit.currentUserId, equals(testUser.uid));
      },
    );

    blocTest<FavoriteCubit, FavoriteState>(
      'clears user data and loads guest favorites when user signs out',
      build: () => buildCubit(SessionAuthenticated(user: testUser)),
      act: (cubit) async {
        // Wait for initial constructor events to settle
        await Future.delayed(Duration.zero);
        // Simulate user clicking sign out
        sessionStreamController.add(SessionGuest(user: guestUser));
      },
      skip: 1, // Skips the async Loaded from the initial auth state
      expect: () => [isA<FavoriteLoading>(), isA<FavoriteLoaded>()],
      verify: (cubit) {
        // 1. Verify we never merged because the initial state was a hot restart, 
        // and sign out shouldn't merge either.
        verifyNever(() => mockMergeUseCase(any()));

        // 2. Verify it instantly switched to reading guest data from Hive
        verify(
          () => mockGetFavoritesUseCase(userId: 'guest'),
        ).called(greaterThan(0));

        // 3. Verify internal state ID is updated
        expect(cubit.currentUserId, equals('guest'));
      },
    );
  });

  group('FavoriteCubit - toggle', () {
    FavoriteEntity fav(int id, {DateTime? addedAt}) => FavoriteEntity(
      specificId: id,
      tmbdId: id,
      title: 'Title $id',
      posterImage: '/p.jpg',
      backdropImage: '/b.jpg',
      contentType: ContentType.movies,
      date: '2020-01-01',
      rating: 7,
      genres: const [],
      addedAt: addedAt,
    );

    Future<FavoriteCubit> loadedCubit(List<FavoriteEntity> saved) async {
      when(
        () => mockGetFavoritesUseCase(
          userId: any(named: 'userId'),
          contentType: any(named: 'contentType'),
        ),
      ).thenAnswer((_) async => Right(saved));
      final cubit = buildCubit(SessionGuest(user: guestUser));
      await Future.delayed(Duration.zero);
      return cubit;
    }

    setUpAll(() {
      registerFallbackValue(fav(0));
      registerFallbackValue(ContentType.movies);
    });

    test('adding puts the item first with a date and persists it', () async {
      when(
        () => mockAddFavoriteUseCase(any()),
      ).thenAnswer((_) async => const Right(unit));
      final cubit = await loadedCubit([fav(1)]);

      await cubit.toggleFavorite(fav(2));

      final state = cubit.state as FavoriteLoaded;
      expect(state.items.map((f) => f.specificId), [2, 1]);
      expect(state.items.first.addedAt, isNotNull);
      expect(cubit.isFavorite(2, ContentType.movies), isTrue);
      verify(() => mockAddFavoriteUseCase(any())).called(1);
    });

    test('removing drops the item and persists it', () async {
      when(
        () => mockRemoveFavoriteUseCase(
          specificId: any(named: 'specificId'),
          contentType: any(named: 'contentType'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => const Right(unit));
      final cubit = await loadedCubit([fav(1), fav(2)]);

      await cubit.toggleFavorite(fav(1));

      expect(
        (cubit.state as FavoriteLoaded).items.map((f) => f.specificId),
        [2],
      );
    });

    test('a failed add is undone and keeps the other items', () async {
      when(
        () => mockAddFavoriteUseCase(any()),
      ).thenAnswer((_) async => Left(ServerFailure(errorMessage: 'boom')));
      final cubit = await loadedCubit([fav(1)]);

      await cubit.toggleFavorite(fav(2));

      expect(
        (cubit.state as FavoriteLoaded).items.map((f) => f.specificId),
        [1],
      );
    });

    test('a failed removal puts the original back with its date', () async {
      final savedAt = DateTime(2026, 3, 3);
      when(
        () => mockRemoveFavoriteUseCase(
          specificId: any(named: 'specificId'),
          contentType: any(named: 'contentType'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => Left(ServerFailure(errorMessage: 'boom')));
      final cubit = await loadedCubit([fav(1, addedAt: savedAt)]);

      await cubit.toggleFavorite(fav(1));

      final items = (cubit.state as FavoriteLoaded).items;
      expect(items.single.specificId, 1);
      expect(items.single.addedAt, savedAt);
    });
  });
}
