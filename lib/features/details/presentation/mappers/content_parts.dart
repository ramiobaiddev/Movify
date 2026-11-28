import 'package:movify/features/details/domain/value_objects/cast.dart';
import 'package:movify/features/details/domain/value_objects/genre.dart';
import 'package:movify/features/details/domain/value_objects/production_company.dart';
import 'package:movify/features/details/domain/value_objects/production_country.dart';
import 'package:movify/features/details/domain/value_objects/result.dart';
import 'package:movify/features/details/domain/value_objects/review_results.dart';
import 'package:movify/features/details/presentation/mappers/formatters.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

/// Parts that movies, series and seasons all have.

const int _maxCast = 20;
const int _maxReviews = 20;

List<DetailsGenre> genresOf(List<Genre> genres) => [
  for (final genre in genres)
    if (genre.id != null && nonEmpty(genre.name) != null)
      DetailsGenre(id: genre.id!, name: genre.name!.trim()),
];

List<CastMember> castOf(List<Cast> cast) => [
  for (final person in cast)
    if (person.id != null && nonEmpty(person.name) != null)
      CastMember(
        id: person.id!,
        name: person.name!.trim(),
        character: nonEmpty(person.character),
        profilePath: nonEmpty(person.profilePath),
      ),
].take(_maxCast).toList(growable: false);

List<ReviewItem> reviewsOf(List<ReviewResults>? reviews) => [
  for (final review in reviews ?? const <ReviewResults>[])
    if (nonEmpty(review.content) != null)
      ReviewItem(
        author:
            nonEmpty(review.authorDetails?.name) ??
            nonEmpty(review.author) ??
            'Anonymous',
        content: review.content!.trim(),
        avatarPath: _avatar(review.authorDetails?.avatarPath),
        rating: review.authorDetails?.rating,
        createdAt: review.createdAt,
      ),
].take(_maxReviews).toList(growable: false);

/// TMDB returns either `/abc.jpg` or `/https://secure.gravatar.com/...`.
String? _avatar(String? path) {
  final value = nonEmpty(path);
  if (value == null) {
    return null;
  }
  return value.startsWith('/http') ? value.substring(1) : value;
}

/// YouTube videos only, official trailers first.
List<VideoItem> videosOf(List<Result>? videos) {
  final youtube = [
    for (final video in videos ?? const <Result>[])
      if (video.site == 'YouTube' && nonEmpty(video.key) != null) video,
  ];
  int rank(Result video) => switch ((video.type, video.official ?? false)) {
    ('Trailer', true) => 0,
    ('Trailer', false) => 1,
    ('Teaser', _) => 2,
    _ => 3,
  };
  youtube.sort((a, b) => rank(a).compareTo(rank(b)));
  return [
    for (final video in youtube)
      VideoItem(
        youtubeKey: video.key!,
        name: nonEmpty(video.name) ?? 'Video',
      ),
  ];
}

/// Country, language and company rows of the Information section.
Iterable<InfoRow> originInfoRows(
  List<ProductionCountry>? countries,
  List<ProductionCompany>? companies,
  String? language,
) => [
  if (_firstName(countries?.map((c) => c.name)) case final country?)
    InfoRow(label: 'Country', value: country),
  if (nonEmpty(language) case final code?)
    InfoRow(label: 'Language', value: code),
  if (_firstName(companies?.map((c) => c.name)) case final company?)
    InfoRow(label: 'Company', value: company),
];

String? _firstName(Iterable<String?>? names) {
  for (final name in names ?? const <String?>[]) {
    final value = nonEmpty(name);
    if (value != null) {
      return value;
    }
  }
  return null;
}
