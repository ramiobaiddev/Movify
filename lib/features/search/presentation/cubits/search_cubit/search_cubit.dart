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

  void onQueryChanged(String newQuery) {
    _debounceTimer?.cancel();
    if (newQuery.trim().isEmpty) {
      _closeActiveLists();
      loadHistory();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _triggerSearch(query: newQuery, tab: _currentTab);
    });
  }

  void onTabChanged(SearchTab newTab) {
    if (newTab == _currentTab) return;
    _currentTab = newTab;
    _debounceTimer?.cancel();
    final currentState = state;
    if (currentState is SearchActive) {
      _triggerSearch(query: currentState.query, tab: newTab);
    }
  }

  void _triggerSearch({required String query, required SearchTab tab}) {
    _closeActiveLists();
    final currentRevision = state is SearchActive
        ? (state as SearchActive).revision + 1
        : 1;

    switch (tab) {
      case SearchTab.moviesAndSeries:
        final list = PagedCubit<CardDisplayModel>(
          (page) async => (await _searchRepo.searchMulti(
            query: query,
            page: page,
          )).map((p) => p.map((m) => m.toCardDisplay())),
        )..load();
        emit(
          SearchActive(
            query: query,
            tab: tab,
            revision: currentRevision,
            mediaList: list,
          ),
        );

      case SearchTab.movies:
        final list = PagedCubit<CardDisplayModel>(
          (page) async => (await _searchRepo.searchMovies(
            query: query,
            page: page,
          )).map((p) => p.map((m) => m.toCardDisplay())),
        )..load();
        emit(
          SearchActive(
            query: query,
            tab: tab,
            revision: currentRevision,
            mediaList: list,
          ),
        );

      case SearchTab.series:
        final list = PagedCubit<CardDisplayModel>(
          (page) async => (await _searchRepo.searchSeries(
            query: query,
            page: page,
          )).map((p) => p.map((m) => m.toCardDisplay())),
        )..load();
        emit(
          SearchActive(
            query: query,
            tab: tab,
            revision: currentRevision,
            mediaList: list,
          ),
        );

      case SearchTab.people:
        final list = PagedCubit<PersonItem>(
          (page) => _searchRepo.searchPeople(query: query, page: page),
        )..load();
        emit(
          SearchActive(
            query: query,
            tab: tab,
            revision: currentRevision,
            peopleList: list,
          ),
        );

      case SearchTab.keywords:
        final list = PagedCubit<Keyword>(
          (page) => _searchRepo.searchKeywords(query: query, page: page),
        )..load();
        emit(
          SearchActive(
            query: query,
            tab: tab,
            revision: currentRevision,
            keywordList: list,
          ),
        );
    }
  }

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
