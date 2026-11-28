import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/views/reviews_view.dart';
import 'package:movify/features/details/presentation/widgets/details/review_card.dart';

void main() {
  testWidgets('shows the title and one card per review', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: MovifyTheme.dark(),
        home: const ReviewsView(
          reviews: [
            ReviewItem(author: 'Ana', content: 'Great'),
            ReviewItem(author: 'Ben', content: 'Fine'),
          ],
        ),
      ),
    );

    expect(find.text('Reviews'), findsOneWidget);
    expect(find.byType(ReviewCard), findsNWidgets(2));
    expect(find.text('Ben'), findsOneWidget);
  });
}
