import 'package:intl/intl.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/entites/movie_details_entity.dart';
import 'package:movify/features/details/domain/entites/series_details_entity.dart';
import 'package:movify/features/details/domain/value_objects/cast.dart';
import 'package:movify/features/details/domain/value_objects/genre.dart';
import 'package:movify/features/details/domain/value_objects/production_company.dart';
import 'package:movify/features/details/domain/value_objects/production_country.dart';
import 'package:movify/features/details/domain/value_objects/result.dart';
import 'package:movify/features/details/domain/value_objects/review_results.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

const int _maxCast = 20;
const int _maxReviews = 20;

extension MovieDetailsContent on MovieDetailsEntity {
  DetailsContent toContent() {
    final release = _parseDate(date);
    final budget = kBudget ?? 0;
    final revenue = kRevenue ?? 0;

    return DetailsContent(
      id: movieId,
      kind: ContentType.movies,
      title: movieTitle,
      posterPath: _nonEmpty(posterImage),
      backdropPath: _nonEmpty(backgroundImage),
      rating: _rating(rating),
      releaseDate: release,
      meta: [
        if (release != null) '${release.year}',
        if (_runtime(duration) case final runtime?) runtime,
      ],
      overview: overView,
      genres: _genres(kGeners),
      cast: _cast(actorName),
      reviews: _reviews(kReviews?.results),
      videos: _videos(kVideos?.results),
      collectionId: kBelongsToCollection?.id,
      info: [
        if (_nonEmpty(movieStatus) case final status?)
          InfoRow(label: 'Status', value: status),
        ..._countryCompanyLanguage(countries, companies, kLanguages),
        if (budget > 0) InfoRow(label: 'Budget', value: _number(budget)),
        if (revenue > 0) InfoRow(label: 'Revenue', value: _number(revenue)),
        if (_runtime(duration) case final runtime?)
          InfoRow(label: 'Runtime', value: runtime),
        if (release != null)
          InfoRow(label: 'Release date', value: _date(release)),
      ],
    );
  }
}

extension SeriesDetailsContent on SeriesDetailsEntity {
  DetailsContent toContent() {
    final first = _parseDate(firstDate);
    final last = _parseDate(kLastAirDate);

    return DetailsContent(
      id: seiresId,
      kind: ContentType.series,
      title: seriesTitle ?? '',
      posterPath: _nonEmpty(posterImage),
      backdropPath: _nonEmpty(backgroundImage),
      rating: _rating(rating),
      releaseDate: first,
      meta: [
        if (first != null) '${first.year}',
        if (numOfSeason > 0)
          '$numOfSeason ${numOfSeason == 1 ? 'Season' : 'Seasons'}',
        if (numOfEpisoide > 0)
          '$numOfEpisoide ${numOfEpisoide == 1 ? 'Episode' : 'Episodes'}',
      ],
      overview: overView ?? '',
      genres: _genres(geners ?? const []),
      cast: _cast(actorDetails ?? const []),
      reviews: _reviews(kReviews?.results),
      videos: _videos(videoKey ?? kVideos?.results),
      info: [
        if (_nonEmpty(seriesStatus) case final status?)
          InfoRow(label: 'Status', value: status),
        ..._countryCompanyLanguage(countries, companies, kLanguages),
        if (numOfSeason > 0)
          InfoRow(label: 'Seasons', value: '$numOfSeason'),
        if (numOfEpisoide > 0)
          InfoRow(label: 'Episodes', value: '$numOfEpisoide'),
        if (first != null)
          InfoRow(label: 'First air date', value: _date(first)),
        if (last != null) InfoRow(label: 'Last air date', value: _date(last)),
      ],
    );
  }
}

String? _nonEmpty(String? value) =>
    value == null || value.trim().isEmpty ? null : value.trim();

DateTime? _parseDate(String? value) =>
    value == null || value.isEmpty ? null : DateTime.tryParse(value);

double? _rating(double? value) => value == null || value <= 0 ? null : value;

String _date(DateTime date) => DateFormat.yMMMd().format(date);

String _number(int value) => NumberFormat.decimalPattern().format(value);

/// `2hr 42min`, `45min`; null when the runtime is unknown.
String? _runtime(int minutes) {
  if (minutes <= 0) {
    return null;
  }
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) {
    return '${rest}min';
  }
  return rest == 0 ? '${hours}hr' : '${hours}hr ${rest}min';
}

List<DetailsGenre> _genres(List<Genre> genres) => [
  for (final genre in genres)
    if (genre.id != null && _nonEmpty(genre.name) != null)
      DetailsGenre(id: genre.id!, name: genre.name!.trim()),
];

List<CastMember> _cast(List<Cast> cast) => [
  for (final person in cast)
    if (person.id != null && _nonEmpty(person.name) != null)
      CastMember(
        id: person.id!,
        name: person.name!.trim(),
        character: _nonEmpty(person.character),
        profilePath: _nonEmpty(person.profilePath),
      ),
].take(_maxCast).toList(growable: false);

List<ReviewItem> _reviews(List<ReviewResults>? reviews) => [
  for (final review in reviews ?? const <ReviewResults>[])
    if (_nonEmpty(review.content) != null)
      ReviewItem(
        author:
            _nonEmpty(review.authorDetails?.name) ??
            _nonEmpty(review.author) ??
            'Anonymous',
        content: review.content!.trim(),
        avatarPath: _avatar(review.authorDetails?.avatarPath),
        rating: review.authorDetails?.rating,
        createdAt: review.createdAt,
      ),
].take(_maxReviews).toList(growable: false);

/// TMDB returns either `/abc.jpg` or `/https://secure.gravatar.com/...`.
String? _avatar(String? path) {
  final value = _nonEmpty(path);
  if (value == null) {
    return null;
  }
  return value.startsWith('/http') ? value.substring(1) : value;
}

/// YouTube videos only, official trailers first.
List<VideoItem> _videos(List<Result>? videos) {
  final youtube = [
    for (final video in videos ?? const <Result>[])
      if (video.site == 'YouTube' && _nonEmpty(video.key) != null) video,
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
        name: _nonEmpty(video.name) ?? 'Video',
      ),
  ];
}

Iterable<InfoRow> _countryCompanyLanguage(
  List<ProductionCountry>? countries,
  List<ProductionCompany>? companies,
  String? language,
) => [
  if (_firstName(countries?.map((c) => c.name)) case final country?)
    InfoRow(label: 'Country', value: country),
  if (_nonEmpty(language) case final code?)
    InfoRow(label: 'Language', value: code),
  if (_firstName(companies?.map((c) => c.name)) case final company?)
    InfoRow(label: 'Company', value: company),
];

String? _firstName(Iterable<String?>? names) {
  for (final name in names ?? const <String?>[]) {
    final value = _nonEmpty(name);
    if (value != null) {
      return value;
    }
  }
  return null;
}
