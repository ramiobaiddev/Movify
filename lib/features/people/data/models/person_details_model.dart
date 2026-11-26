import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/shared/data/models/media_item_model.dart';
import 'package:movify/shared/domain/entites/media_item.dart';

/// `person/{id}?append_to_response=combined_credits`
class PersonDetailsModel {
  const PersonDetailsModel._(this._details);

  /// TMDB genres for talk shows and news. An actor "appearing" in those is a
  /// guest spot, not a credit worth listing.
  static const _guestAppearanceGenres = {10767, 10763};

  final PersonDetails _details;

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) {
    final department = json['known_for_department'] as String? ?? '';
    final credits = json['combined_credits'] as Map<String, dynamic>? ?? {};

    // Actors are listed by their cast credits, everyone else by crew credits.
    final primaryKey = department == 'Acting' ? 'cast' : 'crew';
    final fallbackKey = primaryKey == 'cast' ? 'crew' : 'cast';
    final primary = credits[primaryKey] as List? ?? const [];
    final entries = primary.isNotEmpty
        ? primary
        : credits[fallbackKey] as List? ?? const [];

    // One person is often credited many times for one title (several jobs,
    // many episodes), so keep one entry per title.
    final seen = <String>{};
    final items = <MediaItemModel>[];
    for (final entry in entries) {
      final item = MediaItemModel.tryFromJson(entry as Map<String, dynamic>);
      if (item == null) {
        continue;
      }
      final isGuestSpot = (item.genreIds ?? const []).any(
        _guestAppearanceGenres.contains,
      );
      if (isGuestSpot || !seen.add('${item.kind.name}_${item.id}')) {
        continue;
      }
      items.add(item);
    }
    items.sort((a, b) => (b.popularity ?? 0).compareTo(a.popularity ?? 0));

    List<MediaItem> ofKind(ContentType kind) =>
        items.where((i) => i.kind == kind).map((i) => i.toEntity()).toList();

    return PersonDetailsModel._(
      PersonDetails(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String? ?? '',
        profilePath: json['profile_path'] as String?,
        biography: (json['biography'] as String? ?? '').trim(),
        birthday: DateTime.tryParse(json['birthday'] as String? ?? ''),
        deathday: DateTime.tryParse(json['deathday'] as String? ?? ''),
        placeOfBirth: json['place_of_birth'] as String? ?? '',
        knownForDepartment: department,
        movies: ofKind(ContentType.movies),
        series: ofKind(ContentType.series),
      ),
    );
  }

  PersonDetails toEntity() => _details;
}
