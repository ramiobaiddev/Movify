import 'package:flutter_test/flutter_test.dart';
import 'package:movify/features/people/data/models/person_details_model.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';

Map<String, dynamic> _movie(int id, double popularity, {String? poster = '/p'}) => {
  'id': id,
  'media_type': 'movie',
  'title': 'Movie $id',
  'poster_path': poster,
  'popularity': popularity,
  'genre_ids': [18],
  'release_date': '2020-01-01',
};

Map<String, dynamic> _tv(int id, double popularity, {List<int> genres = const [18]}) => {
  'id': id,
  'media_type': 'tv',
  'name': 'Show $id',
  'poster_path': '/p',
  'popularity': popularity,
  'genre_ids': genres,
  'first_air_date': '2021-01-01',
};

Map<String, dynamic> _person({
  String department = 'Acting',
  List<Map<String, dynamic>> cast = const [],
  List<Map<String, dynamic>> crew = const [],
}) => {
  'id': 1,
  'name': 'Jane Cooper',
  'known_for_department': department,
  'biography': '  A bio.  ',
  'birthday': '1992-10-24',
  'deathday': null,
  'place_of_birth': 'London, England, UK',
  'profile_path': '/face.jpg',
  'combined_credits': {'cast': cast, 'crew': crew},
};

PersonDetails _parse(Map<String, dynamic> json) =>
    PersonDetailsModel.fromJson(json).toEntity();

void main() {
  test('splits credits into movies and series, most popular first', () {
    final d = _parse(
      _person(cast: [_movie(1, 5), _tv(2, 50), _movie(3, 20), _tv(4, 10)]),
    );

    expect(d.movies.map((m) => m.id), [3, 1]);
    expect(d.series.map((m) => m.id), [2, 4]);
    expect(d.creditCount, 4);
  });

  test('lists a title once even when credited several times', () {
    final d = _parse(_person(cast: [_tv(2, 50), _tv(2, 50), _tv(2, 50)]));

    expect(d.series, hasLength(1));
  });

  test('skips credits without a poster and talk or news appearances', () {
    final d = _parse(
      _person(
        cast: [
          _movie(1, 5, poster: null),
          _tv(2, 50, genres: [10767]),
          _tv(3, 40, genres: [10763]),
          _movie(4, 1),
        ],
      ),
    );

    expect(d.movies.map((m) => m.id), [4]);
    expect(d.series, isEmpty);
  });

  test('non-actors are listed by crew credits', () {
    final d = _parse(
      _person(
        department: 'Directing',
        cast: [_movie(1, 5)],
        crew: [_movie(2, 9)],
      ),
    );

    expect(d.movies.map((m) => m.id), [2]);
  });

  test('falls back to the other list when the main one is empty', () {
    final d = _parse(_person(crew: [_movie(2, 9)]));

    expect(d.movies.map((m) => m.id), [2]);
  });

  test('reads the profile fields', () {
    final d = _parse(_person());

    expect(d.name, 'Jane Cooper');
    expect(d.biography, 'A bio.');
    expect(d.birthday, DateTime(1992, 10, 24));
    expect(d.deathday, isNull);
    expect(d.placeOfBirth, 'London, England, UK');
    expect(d.profilePath, '/face.jpg');
  });

  group('ageAt', () {
    final d = _parse(_person());

    test('before the birthday this year', () {
      expect(d.ageAt(DateTime(2026, 10, 23)), 33);
    });

    test('on the birthday', () {
      expect(d.ageAt(DateTime(2026, 10, 24)), 34);
    });

    test('uses the death date when there is one', () {
      final died = _parse({
        ..._person(),
        'deathday': '2020-01-01',
      });

      expect(died.ageAt(DateTime(2026, 11, 26)), 27);
    });

    test('is null without a birthday', () {
      final none = _parse({..._person(), 'birthday': null});

      expect(none.ageAt(DateTime(2026, 11, 26)), isNull);
    });
  });
}
