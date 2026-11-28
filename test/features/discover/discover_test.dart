import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/presentation/models/discover_collection.dart';
import 'package:movify/features/discover/presentation/models/discover_genre.dart';
import 'package:movify/features/discover/presentation/models/mood.dart';
import 'package:movify/features/discover/presentation/widgets/kind_tabs.dart';
import 'package:movify/features/discover/presentation/widgets/mood_section.dart';
import 'package:movify/shared/data/models/discover_query.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';

void main() {
  group('with_genres', () {
    test('joins with a comma by default (match all)', () {
      final q = DiscoverQuery.build(
        kind: ContentType.movies,
        filters: const DiscoverFilters(genreIds: {35, 18}),
        page: 1,
      );
      expect(q['with_genres'], '35,18');
    });

    test('joins with a pipe when anyGenre is set (match any)', () {
      final q = DiscoverQuery.build(
        kind: ContentType.movies,
        filters: const DiscoverFilters(genreIds: {35, 18}, anyGenre: true),
        page: 1,
      );
      expect(q['with_genres'], '35|18');
    });
  });

  test('every mood has genres for both kinds', () {
    for (final mood in Mood.values) {
      expect(mood.genresFor(ContentType.movies), isNotEmpty);
      expect(mood.genresFor(ContentType.series), isNotEmpty);
    }
  });

  test('collection picture follows the kind', () {
    final c = DiscoverCollection.all.first;
    expect(c.pictureFor(ContentType.movies), c.moviePicture);
    expect(c.pictureFor(ContentType.series), c.tvPicture);
  });

  test('genre id follows the kind', () {
    const action = DiscoverGenre('Action', 28, 10759);
    expect(action.idFor(ContentType.movies), 28);
    expect(action.idFor(ContentType.series), 10759);
  });

  test('genre directory has unique ids per kind', () {
    for (final kind in ContentType.values) {
      final ids = GenreOption.forKind(kind).map((g) => g.id).toList();
      expect(ids.toSet().length, ids.length);
    }
  });

  testWidgets('kind tabs report the tapped kind', (tester) async {
    ContentType? picked;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KindTabs(kind: ContentType.movies, onChanged: (k) => picked = k),
        ),
      ),
    );
    await tester.tap(find.text('Series'));
    expect(picked, ContentType.series);
  });

  testWidgets('mood section reports the tapped mood', (tester) async {
    Mood? picked;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: MoodSection(onTap: (m) => picked = m)),
        ),
      ),
    );
    await tester.tap(find.text(Mood.values.first.label));
    expect(picked, Mood.values.first);
  });
}
