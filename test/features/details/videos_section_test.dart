import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/videos_section.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: MovifyTheme.dark(),
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  const trailer = VideoItem(youtubeKey: 'abc', name: 'Official trailer');
  const teaser = VideoItem(youtubeKey: 'def', name: 'Teaser');

  testWidgets('renders nothing without videos', (tester) async {
    await tester.pumpWidget(
      _wrap(VideosSection(videos: const [], onPlay: (_) {})),
    );

    expect(find.text('Videos'), findsNothing);
  });

  testWidgets('shows names and reports the tapped video', (tester) async {
    VideoItem? played;
    await tester.pumpWidget(
      _wrap(
        VideosSection(
          videos: const [trailer, teaser],
          onPlay: (v) => played = v,
        ),
      ),
    );

    expect(find.text('Videos'), findsOneWidget);
    expect(find.text('Official trailer'), findsOneWidget);

    await tester.tap(find.text('Teaser'));

    expect(played, teaser);
  });
}
