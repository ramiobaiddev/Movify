import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/domain/repo/search_history.dart';
import 'package:movify/features/search/domain/repo/search_repo.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:movify/features/search/presentation/models/search_tab.dart';
import 'package:movify/shared/domain/entites/keyword.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required SearchRepo searchRepo,
    required SearchHistoryRepo historyRepo,
  }) : _searchRepo = searchRepo,
       _historyRepo = historyRepo,
       super(const SearchInitial()) {
    loadHistory();
  }

  final SearchRepo _searchRepo;
  final SearchHistoryRepo _historyRepo;
  Timer? _debounceTimer;
  SearchTab _currentTab = SearchTab.moviesAndSeries;
  String _query = '';

  void onQueryChanged(String newQuery) {
    _debounceTimer?.cancel();
    _query = newQuery.trim();
    if (_query.isEmpty) {
      _closeActiveLists();
      loadHistory();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 350), _triggerSearch);
  }

  void onTabChanged(SearchTab newTab) {
    if (newTab == _currentTab) {
      return;
    }
    _currentTab = newTab;
    _debounceTimer?.cancel();
    if (_query.isNotEmpty) {
      _triggerSearch();
    }
  }

  void _triggerSearch() {
    _closeActiveLists();
    final revision = state is SearchActive
        ? (state as SearchActive).revision + 1
        : 1;
    final query = _query;
    final tab = _currentTab;

    emit(switch (tab) {
      SearchTab.moviesAndSeries ||
      SearchTab.movies ||
      SearchTab.series => SearchActive(
        query: query,
        tab: tab,
        revision: revision,
        mediaList: PagedCubit<CardDisplayModel>(_mediaFetcher(tab, query))
          ..load(),
      ),
      SearchTab.people => SearchActive(
        query: query,
        tab: tab,
        revision: revision,
        peopleList: PagedCubit<PersonItem>(
          (page) => _searchRepo.searchPeople(query: query, page: page),
        )..load(),
      ),
      SearchTab.keywords => SearchActive(
        query: query,
        tab: tab,
        revision: revision,
        keywordList: PagedCubit<Keyword>(
          (page) => _searchRepo.searchKeywords(query: query, page: page),
        )..load(),
      ),
    });
  }

  PageFetcher<CardDisplayModel> _mediaFetcher(SearchTab tab, String query) =>
      (page) async {
        final result = switch (tab) {
          SearchTab.movies => await _searchRepo.searchMovies(
            query: query,
            page: page,
          ),
          SearchTab.series => await _searchRepo.searchSeries(
            query: query,
            page: page,
          ),
          _ => await _searchRepo.searchMulti(query: query, page: page),
        };
        return result.map((p) => p.map((m) => m.toCardDisplay()));
      };

  void _closeActiveLists() {
    final currentState = state;
    if (currentState is SearchActive) {
      currentState.mediaList?.close();
      currentState.peopleList?.close();
      currentState.keywordList?.close();
    }
  }

  Future<void> loadHistory() async {
    try {
      final items = await _historyRepo.getSearchHistory();
      if (!isClosed) {
        emit(SearchHistoryLoaded(history: items));
      }
    } catch (_) {}
  }

  Future<void> addToHistory(SearchHistoryEntity item) async {
    try {
      await _historyRepo.addToSearchHistory(item);
      if (state is SearchHistoryLoaded) {
        await loadHistory();
      }
    } catch (_) {}
  }

  Future<void> deleteFromHistory(int id) async {
    try {
      await _historyRepo.deleteFromSearchHistory(id);
      await loadHistory();
    } catch (_) {}
  }

  Future<void> clearHistory() async {
    try {
      await _historyRepo.clearSearchHistory();
      if (!isClosed) {
        emit(const SearchHistoryLoaded(history: []));
      }
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _closeActiveLists();
    return super.close();
  }
}
