import 'package:movify/core/utils/enums/content_type.dart';

/// A movie or a series, for lists that mix both (e.g. `trending/all`).
/// [kind] is [ContentType.movies] or [ContentType.series].
final class MediaItem {
  const MediaItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.rating,
    required this.releaseDate,
    required this.genreIds,
    required this.popularity,
  });

  final int id;
  final ContentType kind;
  final String title;
  final String posterPath;
  final String backdropPath;
  final double rating;

  /// TMDB date (`YYYY-MM-DD`) or empty.
  final String releaseDate;
  final List<int> genreIds;
  final double popularity;
}
