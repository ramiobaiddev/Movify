import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/details/presentation/mappers/release_countdown.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/details/last_aired_card.dart';
import 'package:movify/features/details/presentation/widgets/details/next_episode_card.dart';
import 'package:movify/features/details/presentation/widgets/details/seasons_row.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: MovifyTheme.dark(),
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

final _episode = EpisodeSummary(
  id: 1,
  name: 'Peter griffin',
  seasonNumber: 7,
  episodeNumber: 8,
  airDate: DateTime(2026, 11, 14),
);

void main() {
  test('daysUntil', () {
    final date = DateTime(2026, 11, 14);

    expect(daysUntil(date, DateTime(2026, 11, 11, 20)), 'in 3 days');
    expect(daysUntil(date, DateTime(2026, 11, 13)), 'tomorrow');
    expect(daysUntil(date, DateTime(2026, 11, 14, 8)), 'today');
  });

  testWidgets('next episode card shows code, title, date and countdown', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(NextEpisodeCard(episode: _episode, today: DateTime(2026, 11, 11))),
    );

    expect(find.text('NEXT EPISODE'), findsOneWidget);
    expect(find.text('S07 Â· E08'), findsOneWidget);
    expect(find.text('Peter griffin'), findsOneWidget);
    expect(find.text('Sat, 14 Nov'), findsOneWidget);
    expect(find.text('in 3 days'), findsOneWidget);
  });

  testWidgets('next episode card without a date has no countdown', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        NextEpisodeCard(
          episode: const EpisodeSummary(
            id: 1,
            name: 'TBA',
            seasonNumber: 1,
            episodeNumber: 1,
          ),
          today: DateTime(2026, 11, 11),
        ),
      ),
    );

    expect(find.textContaining('in '), findsNothing);
  });

  testWidgets('last aired card shows the date and reports taps', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _wrap(LastAiredCard(episode: _episode, onTap: () => taps++)),
    );

    expect(find.text('Aired 14 Nov 2026'), findsOneWidget);

    await tester.tap(find.text('Last aired'));

    expect(taps, 1);
  });

  testWidgets('seasons row counts seasons and reports the tapped one', (
    tester,
  ) async {
    SeasonItem? opened;
    const seasons = [
      SeasonItem(id: 1, number: 1, name: 'Season 1', episodeCount: 8),
      SeasonItem(id: 2, number: 2, name: 'Season 2', episodeCount: 1),
    ];
    await tester.pumpWidget(
      _wrap(
        SeasonsRow(
          seasons: seasons,
          fallbackPosterPath: null,
          onTap: (season) => opened = season,
        ),
      ),
    );

    expect(find.text('2 seasons'), findsOneWidget);
    expect(find.text('1 episode'), findsOneWidget);

    await tester.tap(find.text('Season 2'));

    expect(opened, seasons[1]);
  });
}
