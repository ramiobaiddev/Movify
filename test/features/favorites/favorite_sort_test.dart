import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/presentation/models/favorite_sort.dart';

FavoriteEntity _fav(
  int id,
  String title, {
  double rating = 5,
  String date = '2020-01-01',
  DateTime? addedAt,
}) => FavoriteEntity(
  specificId: id,
  tmbdId: id,
  title: title,
  posterImage: '/p.jpg',
  backdropImage: '/b.jpg',
  contentType: ContentType.movies,
  date: date,
  rating: rating,
  genres: const [],
  addedAt: addedAt,
);

List<int> _ids(List<FavoriteEntity> items) =>
    items.map((f) => f.specificId).toList();

void main() {
  test('recently added puts the newest first and undated items last', () {
    final items = [
      _fav(1, 'A'),
      _fav(2, 'B', addedAt: DateTime(2026, 1, 1)),
      _fav(3, 'C', addedAt: DateTime(2026, 6, 1)),
    ];

    expect(_ids(FavoriteSort.recentlyAdded.apply(items)), [3, 2, 1]);
  });

  test('title sorts case-insensitively', () {
    final items = [_fav(1, 'banana'), _fav(2, 'Apple'), _fav(3, 'cherry')];

    expect(_ids(FavoriteSort.title.apply(items)), [2, 1, 3]);
  });

  test('rating sorts highest first and breaks ties by title', () {
    final items = [
      _fav(1, 'B', rating: 7),
      _fav(2, 'A', rating: 7),
      _fav(3, 'C', rating: 9),
    ];

    expect(_ids(FavoriteSort.rating.apply(items)), [3, 2, 1]);
  });

  test('release date sorts newest first and invalid dates last', () {
    final items = [
      _fav(1, 'A', date: '_'),
      _fav(2, 'B', date: '2019-05-05'),
      _fav(3, 'C', date: '2024-01-01'),
    ];

    expect(_ids(FavoriteSort.releaseDate.apply(items)), [3, 2, 1]);
  });

  test('apply does not change the input list', () {
    final items = [_fav(1, 'B'), _fav(2, 'A')];

    FavoriteSort.title.apply(items);

    expect(_ids(items), [1, 2]);
  });
}
