import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movify/core/utils/enums/content_type.dart';

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
  Map<String, dynamic> toJson(ContentType state) => {'kind': state.name};

  @override
  ContentType? fromJson(Map<String, dynamic> json) => switch (json['kind']) {
    'movies' => ContentType.movies,
    'series' => ContentType.series,
    _ => null,
  };
}
