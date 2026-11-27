import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_state.dart';

FavoriteEntity _fav(int id, ContentType type) => FavoriteEntity(
  specificId: id,
  tmbdId: id,
  title: 'Title $id',
  posterImage: '/p.jpg',
  backdropImage: '/b.jpg',
  contentType: type,
  date: '2020-01-01',
  rating: 7,
  genres: const [],
);

void main() {
  final state = FavoriteLoaded(
    items: [_fav(550, ContentType.movies), _fav(1399, ContentType.series)],
    currentUserId: 'guest',
  );

  test('contains matches id and content type together', () {
    expect(state.contains(550, ContentType.movies), isTrue);
    expect(state.contains(550, ContentType.series), isFalse);
    expect(state.contains(1399, ContentType.series), isTrue);
    expect(state.contains(1, ContentType.movies), isFalse);
  });

  test('ofType keeps only that kind', () {
    expect(state.ofType(ContentType.series).single.specificId, 1399);
  });

  test('isGuest follows the user id', () {
    expect(state.isGuest, isTrue);
    expect(FavoriteLoaded(items: const [], currentUserId: 'u1').isGuest, isFalse);
  });
}
