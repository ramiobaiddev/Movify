import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/entites/movie_details_entity.dart';
import 'package:movify/features/details/domain/entites/series_details_entity.dart';
import 'package:movify/features/details/domain/value_objects/author_details.dart';
import 'package:movify/features/details/domain/value_objects/belongs_to_collection.dart';
import 'package:movify/features/details/domain/value_objects/cast.dart';
import 'package:movify/features/details/domain/value_objects/genre.dart';
import 'package:movify/features/details/domain/value_objects/last_episode_to_air.dart';
import 'package:movify/features/details/domain/value_objects/next_episode_to_air.dart';
import 'package:movify/features/details/domain/value_objects/production_company.dart';
import 'package:movify/features/details/domain/value_objects/production_country.dart';
import 'package:movify/features/details/domain/value_objects/result.dart';
import 'package:movify/features/details/domain/value_objects/review_results.dart';
import 'package:movify/features/details/domain/value_objects/reviews.dart';
import 'package:movify/features/details/domain/value_objects/season.dart';
import 'package:movify/features/details/domain/value_objects/videos.dart';
import 'package:movify/features/details/presentation/mappers/details_content_mapper.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

MovieDetailsEntity _movie({
  int duration = 162,
  String? date = '2026-11-25',
  int budget = 100000000,
  int revenue = 0,
  List<Cast>? cast,
  Videos? videos,
  Reviews? reviews,
}) => MovieDetailsEntity(
  movieId: 7,
  duration: duration,
  actorName: cast ?? const [],
  movieStatus: 'Released',
  movieTitle: 'Spider',
  kGeners: [Genre(id: 28, name: 'Action'), Genre(id: 1)],
  overView: 'Story',
  kReviews: reviews,
  kVideos: videos,
  kBudget: budget,
  kRevenue: revenue,
  kLanguages: 'en',
  countries: [ProductionCountry(name: 'France')],
  companies: [ProductionCompany(name: 'Netflix')],
  kBelongsToCollection: BelongsToCollection(id: 99),
  date: date,
  rating: 8.26,
  posterImage: '/p.jpg',
  backgroundImage: '',
);

void main() {
  group('movie', () {
    test('maps the basics', () {
      final content = _movie().toContent();

      expect(content.kind, ContentType.movies);
      expect(content.title, 'Spider');
      expect(content.posterPath, '/p.jpg');
      expect(content.backdropPath, isNull);
      expect(content.meta, ['2026', '2hr 42min']);
      expect(content.collectionId, 99);
      expect(content.genres, const [DetailsGenre(id: 28, name: 'Action')]);
    });

    test('info rows skip unknown values', () {
      final labels = _movie().toContent().info.map((r) => r.label).toList();

      expect(labels, [
        'Status',
        'Country',
        'Language',
        'Company',
        'Budget',
        'Runtime',
        'Release date',
      ]);
      expect(
        _movie().toContent().info.firstWhere((r) => r.label == 'Budget').value,
        '100,000,000',
      );
    });

    test('unknown runtime and date leave no empty facts', () {
      final content = _movie(duration: 0, date: null).toContent();

      expect(content.meta, isEmpty);
      expect(content.info.map((r) => r.label), isNot(contains('Runtime')));
      expect(content.releaseDate, isNull);
    });

    test('runtime formatting', () {
      expect(_movie(duration: 45).toContent().meta.last, '45min');
      expect(_movie(duration: 120).toContent().meta.last, '2hr');
    });

    test('upcoming depends on the release date', () {
      final content = _movie().toContent();

      expect(content.isUpcoming(DateTime(2026, 11, 1)), isTrue);
      expect(content.isUpcoming(DateTime(2026, 11, 26)), isFalse);
      expect(_movie(date: null).toContent().isUpcoming(DateTime(2020)), isFalse);
    });

    test('cast keeps people with an id and name, capped at 20', () {
      final cast = [
        for (var i = 0; i < 30; i++) Cast(id: i, name: 'A$i', character: 'C'),
        Cast(name: 'No id'),
      ];

      final content = _movie(cast: cast).toContent();

      expect(content.cast, hasLength(20));
      expect(content.cast.first.character, 'C');
    });

    test('reviews prefer the profile name and fix gravatar paths', () {
      final reviews = Reviews(
        results: [
          ReviewResults(
            author: 'user',
            authorDetails: AuthorDetails(
              name: 'Real Name',
              avatarPath: '/https://secure.gravatar.com/avatar/1',
              rating: 8,
            ),
            content: ' Great ',
          ),
          ReviewResults(author: 'x', content: ' '),
          ReviewResults(content: 'No author'),
        ],
      );

      final items = _movie(reviews: reviews).toContent().reviews;

      expect(items, hasLength(2));
      expect(items.first.author, 'Real Name');
      expect(items.first.content, 'Great');
      expect(items.first.avatarPath, 'https://secure.gravatar.com/avatar/1');
      expect(items.last.author, 'Anonymous');
    });

    test('videos are YouTube only with official trailers first', () {
      final videos = Videos(
        results: [
          Result(key: 'a', site: 'YouTube', type: 'Clip', name: 'Clip'),
          Result(key: 'b', site: 'Vimeo', type: 'Trailer'),
          Result(
            key: 'c',
            site: 'YouTube',
            type: 'Trailer',
            official: true,
            name: 'Official',
          ),
          Result(key: 'd', site: 'YouTube', type: 'Teaser'),
        ],
      );

      final items = _movie(videos: videos).toContent().videos;

      expect(items.map((v) => v.youtubeKey), ['c', 'd', 'a']);
    });
  });

  group('series', () {
    SeriesDetailsEntity series({
      String? firstDate = '2019-03-01',
      List<Season> seasons = const [],
      NextEpisodeToAir? next,
      LastEpisodeToAir? last,
    }) =>
        SeriesDetailsEntity(
          numOfEpisoide: 48,
          seiresId: 3,
          numOfSeason: 1,
          season: seasons,
          nextEpisodeAir: next,
          lastEpisodeAir: last,
          rating: 0,
          actorDetails: null,
          videoKey: null,
          firstDate: firstDate,
          geners: null,
          seriesTitle: 'Show',
          overView: null,
          backgroundImage: null,
          seriesStatus: 'Returning Series',
          kLastAirDate: '2024-07-15',
        );

    test('maps episodes and drops specials from seasons', () {
      final content = series(
        seasons: [
          Season(id: 1, seasonNumber: 0, name: 'Specials'),
          Season(id: 2, seasonNumber: 1, name: 'Season 1', episodeCount: 8),
        ],
        next: NextEpisodeToAir(
          id: 10,
          name: 'Peter',
          seasonNumber: 7,
          episodeNumber: 8,
          airDate: '2026-11-14',
        ),
        last: LastEpisodeToAir(id: 9, seasonNumber: 7, episodeNumber: 7),
      ).toContent();

      expect(content.seasons.map((s) => s.number), [1]);
      expect(content.nextEpisode?.code, 'S07 · E08');
      expect(content.nextEpisode?.airDate, DateTime(2026, 11, 14));
      expect(content.lastEpisode?.name, 'Episode 7');
    });

    test('episodes without ids are dropped', () {
      final content = series(next: NextEpisodeToAir(name: 'x')).toContent();

      expect(content.nextEpisode, isNull);
    });

    test('maps counts, singular and plural', () {
      final content = series().toContent();

      expect(content.kind, ContentType.series);
      expect(content.meta, ['2019', '1 Season', '48 Episodes']);
      expect(content.rating, isNull);
      expect(content.collectionId, isNull);
    });

    test('info has the air dates', () {
      final info = series().toContent().info;

      expect(info.map((r) => r.label), [
        'Status',
        'Seasons',
        'Episodes',
        'First air date',
        'Last air date',
      ]);
    });

    test('missing values are tolerated', () {
      final content = series(firstDate: null).toContent();

      expect(content.releaseDate, isNull);
      expect(content.overview, '');
      expect(content.genres, isEmpty);
    });
  });
}
