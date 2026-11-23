import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/media_item.dart';

class MediaItemModel {
  const MediaItemModel({
    required this.id,
    required this.kind,
    required this.title,
    required this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.releaseDate,
    this.genreIds,
    this.popularity,
  });

  final int id;
  final ContentType kind;
  final String title;
  final String posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final String? releaseDate;
  final List<int>? genreIds;
  final double? popularity;

  /// Reads one entry of a mixed TMDB list. Returns null for anything that is
  /// not a movie or a series (people), or that has no poster or id.
  static MediaItemModel? tryFromJson(Map<String, dynamic> json) {
    final kind = switch (json['media_type']) {
      'movie' => ContentType.movies,
      'tv' => ContentType.series,
      _ => null,
    };
    final id = (json['id'] as num?)?.toInt();
    final poster = json['poster_path'] as String?;
    if (kind == null || id == null || poster == null) return null;

    final isMovie = kind == ContentType.movies;
    return MediaItemModel(
      id: id,
      kind: kind,
      title: (isMovie ? json['title'] : json['name']) as String? ?? '',
      posterPath: poster,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      releaseDate:
          (isMovie ? json['release_date'] : json['first_air_date']) as String?,
      genreIds: (json['genre_ids'] as List?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
    );
  }

  MediaItem toEntity() => MediaItem(
    id: id,
    kind: kind,
    title: title,
    posterPath: posterPath,
    backdropPath: backdropPath ?? '',
    rating: voteAverage ?? 0,
    releaseDate: releaseDate ?? '',
    genreIds: genreIds ?? const [],
    popularity: popularity ?? 0,
  );
}
