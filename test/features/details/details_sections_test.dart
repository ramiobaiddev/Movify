import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/details/presentation/mappers/release_countdown.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/details_title_block.dart';
import 'package:movify/features/details/presentation/widgets/sections/genre_chips.dart';
import 'package:movify/features/details/presentation/widgets/sections/information_section.dart';
import 'package:movify/features/details/presentation/widgets/sections/reviews_section.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: MovifyTheme.dark(),
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  group('releaseCountdown', () {
    final release = DateTime(2026, 11, 25);

    test('counts days', () {
      expect(
        releaseCountdown(release, DateTime(2026, 11, 13, 18)),
        'Releases Wed, Nov 25 · in 12 days',
      );
    });

    test('tomorrow and today', () {
      expect(
        releaseCountdown(release, DateTime(2026, 11, 24, 23)),
        'Releases Wed, Nov 25 · tomorrow',
      );
      expect(
        releaseCountdown(release, DateTime(2026, 11, 25, 9)),
        'Releases Wed, Nov 25 · today',
      );
    });
  });

  testWidgets('title block shows facts, rating and the coming soon badge', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const DetailsTitleBlock(
          title: 'Spider',
          meta: ['2026', '2hr 42min'],
          rating: 8.26,
          comingSoon: true,
          releaseLine: 'Releases Wed, Nov 25 · in 12 days',
        ),
      ),
    );

    expect(find.text('Spider'), findsOneWidget);
    expect(find.text('2hr 42min'), findsOneWidget);
    expect(find.text('8.3'), findsOneWidget);
    expect(find.text('Coming soon'), findsOneWidget);
    expect(find.text('Releases Wed, Nov 25 · in 12 days'), findsOneWidget);
  });

  testWidgets('genre chips report the tapped genre', (tester) async {
    DetailsGenre? tapped;
    await tester.pumpWidget(
      _wrap(
        GenreChips(
          genres: const [
            DetailsGenre(id: 1, name: 'Action'),
            DetailsGenre(id: 2, name: 'Drama'),
          ],
          onTap: (genre) => tapped = genre,
        ),
      ),
    );

    await tester.tap(find.text('Drama'));

    expect(tapped?.id, 2);
  });

  testWidgets('information rows list label and value', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const InformationSection(
          rows: [InfoRow(label: 'Status', value: 'Released')],
        ),
      ),
    );

    expect(find.text('Information'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Released'), findsOneWidget);
  });

  group('ReviewsSection', () {
    const review = ReviewItem(author: 'Rami', content: 'Great film');

    testWidgets('shows the first review and the link when there are more', (
      tester,
    ) async {
      var opened = 0;
      await tester.pumpWidget(
        _wrap(
          ReviewsSection(
            reviews: const [review, review],
            onSeeMore: () => opened++,
          ),
        ),
      );

      expect(find.text('Rami'), findsOneWidget);
      await tester.tap(find.text('See more reviews'));
      expect(opened, 1);
    });

    testWidgets('no link for a single review, nothing for none', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(ReviewsSection(reviews: const [review], onSeeMore: () {})),
      );
      expect(find.text('See more reviews'), findsNothing);

      await tester.pumpWidget(_wrap(const ReviewsSection(reviews: [])));
      expect(find.text('Reviews'), findsNothing);
    });
  });
}
