import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widget_previews.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/stacked_cards_carousel.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

@Preview(name: 'Hero 3D Carousel Preview')
Widget heroCarouselPreview() => const _CarouselPreviewApp();

class _CarouselPreviewApp extends StatelessWidget {
  const _CarouselPreviewApp();

  static const sampleMovies = [
    CardDisplayModel(
      id: 1,
      title: 'Spider-Man: Brand New Day',
      posterPath: '/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      rating: 8.3,
      date: '2026-05-01',
      genreIds: [878], // Science Fiction
      contentType: ContentType.movies,
    ),
    CardDisplayModel(
      id: 2,
      title: 'Deadpool & Wolverine',
      posterPath: '/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
      rating: 7.9,
      date: '2024-07-26',
      genreIds: [28], // Action
      contentType: ContentType.movies,
    ),
    CardDisplayModel(
      id: 3,
      title: 'Dune: Part Two',
      posterPath: '/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
      rating: 8.5,
      date: '2024-03-01',
      genreIds: [878], // Science Fiction
      contentType: ContentType.movies,
    ),
    CardDisplayModel(
      id: 4,
      title: 'Interstellar',
      posterPath: '/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      rating: 8.7,
      date: '2014-11-07',
      genreIds: [878], // Science Fiction
      contentType: ContentType.movies,
    ),
    CardDisplayModel(
      id: 5,
      title: 'Avengers: Secret Wars',
      posterPath: '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      rating: 9.1,
      date: '2027-05-07',
      genreIds: [28], // Action
      contentType: ContentType.movies,
    ),
  ];

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: MovifyTheme.dark(),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Hero Carousel Preview'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: StackedCardsCarousel(cardModel: sampleMovies),
        ),
      ),
    ),
  );
}
