import 'package:equatable/equatable.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

class SeeAllState extends Equatable {
  const SeeAllState({
    required this.kind,
    required this.filters,
    required this.list,
    required this.revision,
    this.droppedGenreIds = const {},
  });

  final ContentType kind;
  final DiscoverFilters filters;

  /// The list for the current query. A new query gets a new cubit; give the
  /// BlocProvider `key: ValueKey(revision)`.
  final PagedCubit<CardDisplayModel> list;
  final int revision;

  /// Genres lost by the last Movies/Series switch (the screen shows a message,
  /// then calls `SeeAllCubit.clearNotice`).
  final Set<int> droppedGenreIds;

  @override
  List<Object?> get props => [kind, filters, revision, droppedGenreIds];
}
