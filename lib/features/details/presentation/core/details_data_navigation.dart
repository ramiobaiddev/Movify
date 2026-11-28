import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';

sealed class DetailsNavigationData {
  final int tmdbId;
  final ContentType contentType;
  final String posterImage;
  final String? backdropImage;
  final int specificId;

  const DetailsNavigationData({
    required this.tmdbId,
    required this.contentType,
    required this.posterImage,
    this.backdropImage,
    required this.specificId,
  });

  /// Short name for the pinned app bar.
  String get barTitle;
}

class MovieNavData extends DetailsNavigationData {
  final String title;
  final String? date;
  final double? rating;
  final List<int>? genres;

  const MovieNavData({
    required super.tmdbId,
    required this.title,
    this.date,
    this.rating,
    required super.posterImage,
    super.backdropImage,
    this.genres,
    required super.specificId,
  }) : super(contentType: ContentType.movies);

  @override
  String get barTitle => title;
}

class SeriesNavData extends DetailsNavigationData {
  final String title;
  final String? date;
  final double? rating;
  final List<int>? genres;

  const SeriesNavData({
    required super.tmdbId,
    required this.title,
    this.date,
    this.rating,
    required super.posterImage,
    super.backdropImage,
    this.genres,
    required super.specificId,
  }) : super(contentType: ContentType.series);

  @override
  String get barTitle => title;
}

class SeasonNavData extends DetailsNavigationData {
  final int seasonNumber;
  final String? seasonName;
  final double? rating;
  final String? date;

  /// Every season of the series, for the previous / next bar.
  final List<SeasonItem> seasons;
  final String? seriesTitle;

  const SeasonNavData({
    required super.tmdbId,
    required this.seasonNumber,
    this.seasonName,
    this.rating,
    this.date,
    this.seasons = const [],
    this.seriesTitle,
    required super.posterImage,
    super.backdropImage,
    required super.specificId,
  }) : super(contentType: ContentType.seasons);

  @override
  String get barTitle => seasonName ?? 'Season $seasonNumber';

  factory SeasonNavData.fromItem(
    SeasonItem season, {
    required int tmdbId,
    required String? seriesPosterPath,
    required String? backdropPath,
    required List<SeasonItem> seasons,
    String? seriesTitle,
  }) => SeasonNavData(
    tmdbId: tmdbId,
    seasonNumber: season.number,
    seasonName: season.name,
    rating: season.rating,
    date: season.airDate,
    seasons: seasons,
    seriesTitle: seriesTitle,
    posterImage: season.posterPath ?? seriesPosterPath ?? '',
    backdropImage: backdropPath,
    specificId: season.id,
  );
}

class EpisodeNavData extends DetailsNavigationData {
  final int seasonNumber;
  final int episodeNumber;
  final String? date;
  final double? rating;
  final String? seriesPosterPath;
  final String? seriesTitle;

  const EpisodeNavData({
    required super.tmdbId,
    required this.seasonNumber,
    required this.episodeNumber,
    this.date,
    this.rating,
    this.seriesPosterPath,
    this.seriesTitle,
    required super.posterImage,
    super.backdropImage,
    required super.specificId,
  }) : super(contentType: ContentType.episodes);

  @override
  String get barTitle => 'Episode $episodeNumber';

  /// The same series and season, pointed at [episode].
  EpisodeNavData forEpisode(EpisodeItem episode) => EpisodeNavData(
    tmdbId: tmdbId,
    seasonNumber: episode.seasonNumber,
    episodeNumber: episode.number,
    date: episode.airDate?.toIso8601String(),
    rating: episode.rating,
    seriesPosterPath: seriesPosterPath,
    seriesTitle: seriesTitle,
    posterImage: episode.stillPath ?? posterImage,
    backdropImage: backdropImage,
    specificId: episode.id,
  );
}
