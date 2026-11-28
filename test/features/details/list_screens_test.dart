import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/views/cast_crew_view.dart';
import 'package:movify/shared/presentation/widgets/common/section_title.dart';

Widget _app(Widget child) =>
    MaterialApp(theme: MovifyTheme.dark(), home: child);

void main() {
  testWidgets('section title shows a chevron and reports taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _app(Scaffold(body: SectionTitle('Similar', onTap: () => taps++))),
    );

    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
    await tester.tap(find.text('Similar'));

    expect(taps, 1);
  });

  testWidgets('section title without onTap has no chevron', (tester) async {
    await tester.pumpWidget(_app(const Scaffold(body: SectionTitle('Similar'))));

    expect(find.byIcon(Icons.chevron_right_rounded), findsNothing);
  });

  testWidgets('cast & crew lists every person it is given', (tester) async {
    await tester.pumpWidget(
      _app(
        CastCrewView(
          cast: [
            for (var i = 1; i <= 3; i++) CastMember(id: i, name: 'Person $i'),
          ],
        ),
      ),
    );

    expect(find.text('Cast & crew'), findsOneWidget);
    expect(find.text('Person 1'), findsOneWidget);
    expect(find.text('Person 3'), findsOneWidget);
  });

  test('season episode label', () {
    const one = SeasonItem(id: 1, number: 1, name: 'S1', episodeCount: 1);
    const many = SeasonItem(id: 2, number: 2, name: 'S2', episodeCount: 8);
    const none = SeasonItem(id: 3, number: 3, name: 'S3');

    expect(one.episodesLabel, '1 episode');
    expect(many.episodesLabel, '8 episodes');
    expect(none.episodesLabel, isNull);
  });
}
