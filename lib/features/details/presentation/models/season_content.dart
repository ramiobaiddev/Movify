import 'package:equatable/equatable.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

/// Everything the season screen shows, in the shape the widgets want.
class SeasonContent extends Equatable {
  const SeasonContent({
    required this.id,
    required this.number,
    required this.title,
    this.posterPath,
    this.rating,
    this.meta = const [],
    this.overview = '',
    this.cast = const [],
    this.videos = const [],
    this.info = const [],
    this.episodes = const [],
  });

  final int id;
  final int number;
  final String title;
  final String? posterPath;
  final double? rating;

  /// Short facts under the title, e.g. `2026`, `8 Episodes`.
  final List<String> meta;
  final String overview;
  final List<CastMember> cast;
  final List<VideoItem> videos;
  final List<InfoRow> info;

  /// In episode order, oldest first.
  final List<EpisodeItem> episodes;

  VideoItem? get trailer => videos.isEmpty ? null : videos.first;

  @override
  List<Object?> get props => [
    id,
    number,
    title,
    posterPath,
    rating,
    meta,
    overview,
    cast,
    videos,
    info,
    episodes,
  ];
}

class EpisodeItem extends Equatable {
  const EpisodeItem({
    required this.id,
    required this.seasonNumber,
    required this.number,
    required this.name,
    this.airDate,
    this.runtime,
    this.stillPath,
    this.rating,
    this.overview = '',
    this.guestStars = const [],
  });

  final int id;
  final int seasonNumber;
  final int number;
  final String name;
  final DateTime? airDate;

  /// Minutes.
  final int? runtime;
  final String? stillPath;
  final double? rating;
  final String overview;
  final List<CastMember> guestStars;

  /// `E02`.
  String get code => 'E${number.toString().padLeft(2, '0')}';

  /// `S04 · E01`.
  String get fullCode =>
      'S${seasonNumber.toString().padLeft(2, '0')} · $code';

  /// Not aired yet on [today].
  bool isUpcoming(DateTime today) {
    final date = airDate;
    return date != null &&
        DateTime(date.year, date.month, date.day).isAfter(
          DateTime(today.year, today.month, today.day),
        );
  }

  @override
  List<Object?> get props => [
    id,
    seasonNumber,
    number,
    name,
    airDate,
    runtime,
    stillPath,
    rating,
    overview,
    guestStars,
  ];
}
