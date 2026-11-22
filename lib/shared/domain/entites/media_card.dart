import 'package:equatable/equatable.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';

enum MediaType { movie, series }

/// What a poster card needs, regardless of whether it is a movie or a series.
/// Rows that mix both (home "For you", "All-time favorites") hold these.
class MediaCard extends Equatable {
  const MediaCard({
    required this.id,
    required this.type,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  final int id;
  final MediaType type;
  final String title;
  final String posterPath;
  final double voteAverage;

  /// TMDB date string, `YYYY-MM-DD`, or empty.
  final String releaseDate;

  /// Four-digit year, or empty when the date is missing.
  String get year => releaseDate.length >= 4 ? releaseDate.substring(0, 4) : '';

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    posterPath,
    voteAverage,
    releaseDate,
  ];
}

extension MovieEntityToMediaCard on MovieEntity {
  MediaCard toMediaCard() => MediaCard(
    id: id,
    type: MediaType.movie,
    title: title,
    posterPath: posterPath,
    voteAverage: voteAverage,
    releaseDate: releaseDate,
  );
}

extension SeriesEntityToMediaCard on SeriesEntity {
  MediaCard toMediaCard() => MediaCard(
    id: id,
    type: MediaType.series,
    title: name,
    posterPath: posterPath,
    voteAverage: voteAverage,
    releaseDate: firstAirDate,
  );
}
