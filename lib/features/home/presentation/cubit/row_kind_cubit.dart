import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movify/core/utils/enums/content_type.dart';

/// Which kind (Movies or Series) a home row currently shows, remembered
/// across app restarts. One instance per row; [rowId] keeps them separate
/// ("for_you", "all_time_favorites").
class RowKindCubit extends HydratedCubit<ContentType> {
  RowKindCubit({required this.rowId, ContentType initial = ContentType.movies})
    : super(initial);

  final String rowId;

  @override
  String get id => rowId;

  void select(ContentType kind) {
    if (kind == ContentType.movies || kind == ContentType.series) {
      emit(kind);
    }
  }

  @override
  String toJson(ContentType state) => state.name;

  @override
  ContentType? fromJson(dynamic json) => switch (json) {
    'movies' => ContentType.movies,
    'series' => ContentType.series,
    _ => null,
  };
}
