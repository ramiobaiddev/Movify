import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/features/people/presentation/widgets/expandable_biography.dart';
import 'package:movify/features/people/presentation/widgets/person_header.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/widgets/person_list_tile.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: MovifyTheme.dark(),
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  const person = PersonItem(
    id: 1,
    name: 'Jane Doe',
    knownForDepartment: 'Directing',
  );

  group('PersonListTile', () {
    testWidgets('detailed shows department and chevron', (tester) async {
      await tester.pumpWidget(
        _wrap(PersonListTile(person: person, detailed: true, onTap: () {})),
      );
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('Directing'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
    });

    testWidgets('plain shows only the name and reports taps', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _wrap(PersonListTile(person: person, onTap: () => taps++)),
      );
      expect(find.text('Directing'), findsNothing);
      expect(find.byIcon(Icons.chevron_right_rounded), findsNothing);
      await tester.tap(find.text('Jane Doe'));
      expect(taps, 1);
    });
  });

  group('ExpandableBiography', () {
    testWidgets('short text has no toggle', (tester) async {
      await tester.pumpWidget(_wrap(const ExpandableBiography(text: 'Short.')));
      expect(find.text('Read more'), findsNothing);
    });

    testWidgets('long text toggles', (tester) async {
      await tester.pumpWidget(
        _wrap(ExpandableBiography(text: List.filled(200, 'word').join(' '))),
      );
      expect(find.text('Read more'), findsOneWidget);
      await tester.tap(find.text('Read more'));
      await tester.pump();
      expect(find.text('Show less'), findsOneWidget);
    });
  });

  group('PersonHeader', () {
    PersonDetails details({DateTime? died}) => PersonDetails(
      id: 7,
      name: 'Jane Doe',
      profilePath: null,
      biography: '',
      birthday: DateTime(1992, 10, 24),
      deathday: died,
      placeOfBirth: 'Cairo, Egypt',
      knownForDepartment: 'Acting',
      movies: const [],
      series: const [],
    );

    testWidgets('shows birth date with age and place', (tester) async {
      await tester.pumpWidget(
        _wrap(PersonHeader(details: details(), today: DateTime(2026, 11, 27))),
      );
      expect(find.text('Oct 24, 1992 (34)'), findsOneWidget);
      expect(find.text('Cairo, Egypt'), findsOneWidget);
      expect(find.text('Acting · 0 credits'), findsOneWidget);
    });
  });
}
