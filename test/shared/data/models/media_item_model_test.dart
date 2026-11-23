import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/data/models/media_item_model.dart';

void main() {
  test('reads a movie', () {
    final m = MediaItemModel.tryFromJson({
      'id': 1,
      'media_type': 'movie',
      'title': 'Dune',
      'poster_path': '/p.jpg',
      'backdrop_path': '/b.jpg',
      'vote_average': 8,
      'release_date': '2021-10-22',
      'genre_ids': [12, 878],
      'popularity': 99.5,
    })!;
    final e = m.toEntity();
    expect(e.kind, ContentType.movies);
    expect(e.title, 'Dune');
    expect(e.rating, 8.0);
    expect(e.releaseDate, '2021-10-22');
    expect(e.genreIds, [12, 878]);
  });

  test('reads a series using name and first_air_date', () {
    final m = MediaItemModel.tryFromJson({
      'id': 2,
      'media_type': 'tv',
      'name': 'Severance',
      'poster_path': '/p.jpg',
      'first_air_date': '2022-02-18',
    })!;
    expect(m.kind, ContentType.series);
    expect(m.title, 'Severance');
    expect(m.toEntity().releaseDate, '2022-02-18');
    expect(m.toEntity().backdropPath, '');
  });

  test('skips people, missing posters and unknown types', () {
    expect(
      MediaItemModel.tryFromJson({'id': 3, 'media_type': 'person'}),
      isNull,
    );
    expect(
      MediaItemModel.tryFromJson({
        'id': 4,
        'media_type': 'movie',
        'title': 'x',
        'poster_path': null,
      }),
      isNull,
    );
    expect(MediaItemModel.tryFromJson({'id': 5, 'poster_path': '/p'}), isNull);
  });
}
