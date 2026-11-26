import 'package:equatable/equatable.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/presentation/models/search_tab.dart';
import 'package:movify/shared/domain/entites/keyword.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Sealed state hierarchy for Search.
sealed class SearchState extends Equatable {
  const SearchState();

  bool get isIdle => this is SearchInitial || this is SearchHistoryLoaded;
}

/// Initial state while search history is being retrieved from local storage.
final class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object?> get props => [];
}

/// Search history is retrieved and ready.
final class SearchHistoryLoaded extends SearchState {
  const SearchHistoryLoaded({this.history = const []});

  final List<SearchHistoryEntity> history;

  SearchHistoryLoaded copyWith({List<SearchHistoryEntity>? history}) =>
      SearchHistoryLoaded(history: history ?? this.history);

  @override
  List<Object?> get props => [history];
}

/// Active search mode: user entered a query; shows tabs and results.
final class SearchActive extends SearchState {
  const SearchActive({
    required this.query,
    required this.tab,
    required this.revision,
    this.mediaList,
    this.peopleList,
    this.keywordList,
  });

  final String query;
  final SearchTab tab;
  final int revision;
  final PagedCubit<CardDisplayModel>? mediaList;
  final PagedCubit<PersonItem>? peopleList;
  final PagedCubit<Keyword>? keywordList;

  @override
  List<Object?> get props => [
    query,
    tab,
    revision,
    mediaList,
    peopleList,
    keywordList,
  ];
}
