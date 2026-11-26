import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/domain/repo/search_history.dart';
import 'package:movify/features/search/domain/repo/search_repo.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:movify/features/search/presentation/models/search_tab.dart';
import 'package:movify/shared/domain/entites/media_item.dart';

class _SearchRepo extends Mock implements SearchRepo {}

class _HistoryRepo extends Mock implements SearchHistoryRepo {}

const _empty = PageResult<MediaItem>(
  page: 1,
  totalPages: 1,
  totalResults: 0,
  results: [],
);

void main() {
  late _SearchRepo search;
  late _HistoryRepo history;
  late SearchCubit cubit;

  setUp(() {
    search = _SearchRepo();
    history = _HistoryRepo();
    when(
      () => history.getSearchHistory(),
    ).thenAnswer((_) async => <SearchHistoryEntity>[]);
    when(
      () => search.searchMulti(
        query: any(named: 'query'),
        page: any(named: 'page'),
      ),
    ).thenAnswer((_) async => const Right(_empty));
    when(
      () => search.searchMovies(
        query: any(named: 'query'),
        page: any(named: 'page'),
      ),
    ).thenAnswer((_) async => const Right(_empty));
    cubit = SearchCubit(searchRepo: search, historyRepo: history);
  });

  tearDown(() => cubit.close());

  test('starts with history', () async {
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, isA<SearchHistoryLoaded>());
  });

  test('a query becomes an active search after the debounce', () async {
    cubit.onQueryChanged('bat');
    expect(cubit.state, isNot(isA<SearchActive>()));

    await Future<void>.delayed(const Duration(milliseconds: 400));

    final state = cubit.state as SearchActive;
    expect(state.query, 'bat');
    expect(state.tab, SearchTab.moviesAndSeries);
    expect(state.mediaList, isNotNull);
    verify(() => search.searchMulti(query: 'bat', page: 1)).called(1);
  });

  test('changing tab right after typing searches the typed text', () async {
    cubit.onQueryChanged('bat');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    cubit.onQueryChanged('batm');
    cubit.onTabChanged(SearchTab.movies);

    final state = cubit.state as SearchActive;
    expect(state.query, 'batm');
    expect(state.tab, SearchTab.movies);
    verify(() => search.searchMovies(query: 'batm', page: 1)).called(1);
  });

  test('every search gets a new revision and a new list', () async {
    cubit.onQueryChanged('bat');
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final first = cubit.state as SearchActive;

    cubit.onTabChanged(SearchTab.movies);
    final second = cubit.state as SearchActive;

    expect(second.revision, first.revision + 1);
    expect(second.mediaList, isNot(same(first.mediaList)));
    expect(first.mediaList!.isClosed, isTrue);
  });

  test('clearing the query goes back to history', () async {
    cubit.onQueryChanged('bat');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    cubit.onQueryChanged('');
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, isA<SearchHistoryLoaded>());
  });
}
