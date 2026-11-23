import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

extension MovieToCardDisplay on MovieEntity {
  CardDisplayModel toCardDisplay() => CardDisplayModel(
    id: id,
    title: title,
    posterPath: posterPath,
    backdropPath: backdropPath,
    rating: voteAverage,
    genreIds: genreIds,
    date: releaseDate,
    popularity: popularity,
    contentType: ContentType.movies,
  );
}

extension SeriesToCardDisplay on SeriesEntity {
  CardDisplayModel toCardDisplay() => CardDisplayModel(
    id: id,
    title: name,
    posterPath: posterPath,
    backdropPath: backdropPath,
    rating: voteAverage,
    genreIds: genreIds,
    date: firstAirDate,
    popularity: popularity,
    contentType: ContentType.series,
  );
}

extension MediaItemToCardDisplay on MediaItem {
  CardDisplayModel toCardDisplay() => CardDisplayModel(
    id: id,
    title: title,
    posterPath: posterPath,
    backdropPath: backdropPath,
    rating: rating,
    genreIds: genreIds,
    date: releaseDate,
    popularity: popularity,
    contentType: kind,
  );
}

extension CardDisplayYear on CardDisplayModel {
  /// Four-digit year, or empty when the date is missing.
  String get year => (date != null && date!.length >= 4)
      ? date!.substring(0, 4)
      : '';
}
