import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/details/domain/entites/series_season_details_entitiy.dart';
import 'package:movify/features/details/domain/value_objects/episode.dart';
import 'package:movify/features/details/presentation/mappers/details_content_mapper.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/episode_tile.dart';
import 'package:movify/features/details/presentation/widgets/sections/episodes_section.dart';
import 'package:movify/shared/presentation/widgets/sequence_nav_bar.dart';

Widget _wrap(Widget child, {Widget? bar}) => MaterialApp(
  theme: MovifyTheme.dark(),
  home: Scaffold(
    body: SingleChildScrollView(child: child),
    bottomNavigationBar: bar,
  ),
);

List<EpisodeItem> _episodes(int count) => [
  for (var i = 1; i <= count; i++)
    EpisodeItem(
      id: i,
      seasonNumber: 1,
      number: i,
      name: 'Episode title $i',
      airDate: DateTime(2024, 7, i),
      runtime: 24,
    ),
];

void main() {
  group('toSeasonContent', () {
    SeriesSeasonDetailsEntity season(List<Episode> episodes) =>
        SeriesSeasonDetailsEntity(
          seasonName: 'Season 1',
          seasonOverView: 'Story',
          seasonDate: '2024-07-15',
          seasonNum: 1,
          seasonRating: 8.3,
          seasonVideos: null,
          seasonPosterPath: '/p.jpg',
          seasonId: 5,
          seasonCredits: null,
          seasonEpisodes: episodes,
          episodeId: 0,
          tvId: 3,
        );

    test('sorts episodes, sums the runtime and counts them', () {
      final content = season([
        Episode(id: 2, episodeNumber: 2, name: 'B', runtime: 30),
        Episode(id: 1, episodeNumber: 1, name: 'A', runtime: 45),
        Episode(id: 9, name: 'no number'),
      ]).toSeasonContent();

      expect(content.episodes.map((e) => e.name), ['A', 'B']);
      expect(content.meta, ['2024', '2 Episodes']);
      expect(
        content.info.map((r) => '${r.label}: ${r.value}'),
        contains('Total runtime: 1hr 15min'),
      );
    });

    test('episode without a name gets a numbered one', () {
      final content = season([
        Episode(id: 1, episodeNumber: 4),
      ]).toSeasonContent();

      expect(content.episodes.single.name, 'Episode 4');
    });
  });

  test('EpisodeItem.isUpcoming compares days', () {
    final episode = EpisodeItem(
      id: 1,
      seasonNumber: 1,
      number: 1,
      name: 'x',
      airDate: DateTime(2026, 11, 30),
    );

    expect(episode.isUpcoming(DateTime(2026, 11, 28, 23)), isTrue);
    expect(episode.isUpcoming(DateTime(2026, 11, 30, 1)), isFalse);
  });

  testWidgets('episode tile shows number, details and countdown', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        EpisodeTile(
          episode: EpisodeItem(
            id: 1,
            seasonNumber: 1,
            number: 8,
            name: 'Peter',
            airDate: DateTime(2026, 12, 1),
            runtime: 24,
          ),
          today: DateTime(2026, 11, 28),
          onTap: () {},
        ),
      ),
    );

    expect(find.text('E8'), findsOneWidget);
    expect(find.text('1 Dec 2026 · 24min'), findsOneWidget);
    expect(find.text('in 3 days'), findsOneWidget);
  });

  group('EpisodesSection', () {
    Widget section({required bool expanded, VoidCallback? onShowAll}) => _wrap(
      EpisodesSection(
        episodes: _episodes(8),
        expanded: expanded,
        onShowAll: onShowAll ?? () {},
        onTap: (_) {},
        today: DateTime(2026, 11, 28),
      ),
    );

    testWidgets('collapsed: five newest and the show all button', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        section(expanded: false, onShowAll: () => tapped = true),
      );

      expect(find.byType(EpisodeTile), findsNWidgets(5));
      expect(find.text('Episode title 8'), findsOneWidget);
      expect(find.text('Episode title 3'), findsNothing);

      await tester.tap(find.text('Show all episodes'));

      expect(tapped, isTrue);
    });

    testWidgets('expanded: every episode and no button', (tester) async {
      await tester.pumpWidget(section(expanded: true));

      expect(find.byType(EpisodeTile), findsNWidgets(8));
      expect(find.text('Show all episodes'), findsNothing);
    });

    testWidgets('the toggle flips the order', (tester) async {
      await tester.pumpWidget(section(expanded: false));

      expect(find.text('Newest'), findsOneWidget);
      await tester.tap(find.text('Newest'));
      await tester.pump();

      expect(find.text('Oldest'), findsOneWidget);
      expect(find.text('Episode title 1'), findsOneWidget);
      expect(find.text('Episode title 8'), findsNothing);
    });
  });

  group('SequenceNavBar', () {
    testWidgets('unavailable side ignores taps, available ones fire', (
      tester,
    ) async {
      var next = 0;
      var center = 0;
      await tester.pumpWidget(
        _wrap(
          const SizedBox.shrink(),
          bar: SequenceNavBar(
            centerLabel: 'Seasons',
            onCenter: () => center++,
            nextLabel: 'Next · S2',
            onNext: () => next++,
          ),
        ),
      );

      await tester.tap(find.text('Previous'));
      await tester.tap(find.text('Next · S2'));
      await tester.tap(find.text('Seasons'));

      expect(next, 1);
      expect(center, 1);
    });
  });
}
