import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/genre_mapping.dart';

void main() {
  test('movie to tv maps by name and drops the rest', () {
    final r = GenreMapping.convert(
      {28, 12, 878, 35, 27},
      from: ContentType.movies,
      to: ContentType.series,
    );
    expect(r.mapped, {10759, 10765, 35});
    expect(r.dropped, {27});
  });

  test('tv to movie maps combined genres and drops kids/reality', () {
    final r = GenreMapping.convert(
      {10759, 10762, 18},
      from: ContentType.series,
      to: ContentType.movies,
    );
    expect(r.mapped, {28, 18});
    expect(r.dropped, {10762});
  });

  test('same kind is unchanged', () {
    final r = GenreMapping.convert(
      {27},
      from: ContentType.movies,
      to: ContentType.movies,
    );
    expect(r.mapped, {27});
    expect(r.dropped, isEmpty);
  });
}
