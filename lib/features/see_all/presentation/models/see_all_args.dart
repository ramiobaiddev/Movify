import 'package:equatable/equatable.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';

/// What a See all screen was opened with (passed as GoRouter `extra`).
///
/// Two shapes:
///  - fixed: [fixedEndPoint] is set (In theater now, On the air, ...). No
///    filters, no Movies/Series switch, no Reset.
///  - discover: everything else. [kind] and [filters] are the starting query
///    and the user can change both.
class SeeAllArgs extends Equatable {
  const SeeAllArgs.discover({
    required this.kind,
    this.filters = const DiscoverFilters(),
    this.title,
  }) : fixedEndPoint = null;

  const SeeAllArgs.fixed({
    required this.kind,
    required String endPoint,
    this.title,
  })  : fixedEndPoint = endPoint,
        filters = const DiscoverFilters();

  /// [ContentType.movies] or [ContentType.series].
  final ContentType kind;
  final DiscoverFilters filters;
  final String? fixedEndPoint;
  final String? title;

  bool get isFixed => fixedEndPoint != null;

  @override
  List<Object?> get props => [kind, filters, fixedEndPoint, title];
}
