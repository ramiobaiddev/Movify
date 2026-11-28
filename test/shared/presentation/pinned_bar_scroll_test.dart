import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/shared/presentation/widgets/headers/pinned_bar_scroll.dart';

void main() {
  testWidgets('bar fades in once the content scrolls past the toolbar', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PinnedBarScroll(
            bar: Text('bar'),
            slivers: [SliverToBoxAdapter(child: SizedBox(height: 2000))],
          ),
        ),
      ),
    );

    double opacity() =>
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity;

    expect(opacity(), 0);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
    await tester.pump();

    expect(opacity(), 1);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, 300));
    await tester.pump();

    expect(opacity(), 0);
  });
}
