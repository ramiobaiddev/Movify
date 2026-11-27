import 'package:equatable/equatable.dart';
import 'package:movify/core/utils/enums/content_type.dart';

/// Everything the details page shows, in the shape the widgets want.
///
/// Built from a movie or series entity (see `details_content_mapper.dart`) so
/// one page can render both and the sections never look at raw TMDB objects.
class DetailsContent extends Equatable {
  const DetailsContent({
    required this.id,
    required this.kind,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.rating,
    this.releaseDate,
    this.meta = const [],
    this.overview = '',
    this.genres = const [],
    this.cast = const [],
    this.reviews = const [],
    this.videos = const [],
    this.info = const [],
    this.collectionId,
  });

  final int id;
  final ContentType kind;
  final String title;
  final String? posterPath;
  final String? backdropPath;

  /// TMDB vote average, null when there are no votes.
  final double? rating;

  /// Release date (movie) or first air date (series).
  final DateTime? releaseDate;

  /// Short facts under the title, e.g. `2026`, `2hr 42min`.
  final List<String> meta;

  final String overview;
  final List<DetailsGenre> genres;
  final List<CastMember> cast;
  final List<ReviewItem> reviews;
  final List<VideoItem> videos;
  final List<InfoRow> info;

  /// Movie collection this film belongs to, if any.
  final int? collectionId;

  /// Not released yet on [today].
  bool isUpcoming(DateTime today) {
    final date = releaseDate;
    return date != null && date.isAfter(today);
  }

  @override
  List<Object?> get props => [
    id,
    kind,
    title,
    posterPath,
    backdropPath,
    rating,
    releaseDate,
    meta,
    overview,
    genres,
    cast,
    reviews,
    videos,
    info,
    collectionId,
  ];
}

class DetailsGenre extends Equatable {
  const DetailsGenre({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class CastMember extends Equatable {
  const CastMember({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
  });

  final int id;
  final String name;
  final String? character;
  final String? profilePath;

  @override
  List<Object?> get props => [id, name, character, profilePath];
}

class ReviewItem extends Equatable {
  const ReviewItem({
    required this.author,
    required this.content,
    this.avatarPath,
    this.rating,
    this.createdAt,
  });

  final String author;
  final String content;
  final String? avatarPath;
  final double? rating;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [author, content, avatarPath, rating, createdAt];
}

class VideoItem extends Equatable {
  const VideoItem({required this.youtubeKey, required this.name});

  final String youtubeKey;
  final String name;

  @override
  List<Object?> get props => [youtubeKey, name];
}

class InfoRow extends Equatable {
  const InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  List<Object?> get props => [label, value];
}
