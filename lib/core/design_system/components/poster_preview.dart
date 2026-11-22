import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:movify/core/design_system/components/components.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';

// ── Widget Previews ──────────────────────────────────────────

@Preview(name: 'Comparison: 150px vs 104px')
Widget posterCardComparisonPreview() => const PosterCardPreviewApp();

@Preview(name: 'Standard 150px Card', size: Size(200, 320))
Widget single150pxCardPreview() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: MovifyTheme.dark(),
  home: Scaffold(
    body: Center(
      child: PosterCard(
        width: 150,
        imageUrl:
            'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
        title: 'Spider-Man: Brand New Day',
        subtitle: 'Movie',
        rating: 8.3,
        actionButton: _PreviewHeart(isFavorited: false, onTap: () {}),
        onTap: () {},
      ),
    ),
  ),
);

@Preview(name: 'Compact 104px Feed Card', size: Size(160, 260))
Widget compact104pxCardPreview() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: MovifyTheme.dark(),
  home: Scaffold(
    body: Center(
      child: PosterCard(
        width: 104,
        imageUrl:
            'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
        title: 'Deadpool & Wolverine',
        subtitle: 'Movie',
        rating: 7.9,
        actionButton: _PreviewHeart(isFavorited: true, onTap: () {}),
        onTap: () {},
      ),
    ),
  ),
);

// ── Interactive Preview App Container ────────────────────────

class PosterCardPreviewApp extends StatefulWidget {
  const PosterCardPreviewApp({super.key});

  @override
  State<PosterCardPreviewApp> createState() => PosterCardPreviewAppState();
}

class PosterCardPreviewAppState extends State<PosterCardPreviewApp> {
  bool _fav1 = false;
  bool _fav2 = true;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: MovifyTheme.dark(),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('MovifyPosterCard Preview'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Figma Spec (150px) vs Feed Row (104px)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Standard / Component spec size (150px)
                  PosterCard(
                    width: 150,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
                    title: 'Fast X',
                    subtitle: 'Movie',
                    rating: 8.3,
                    actionButton: _PreviewHeart(
                      isFavorited: _fav1,
                      onTap: () => setState(() => _fav1 = !_fav1),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(width: 20),
                  // Feed row compact size (104px)
                  PosterCard(
                    width: 104,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
                    title: 'Deadpool & Wolverine',
                    subtitle: 'Movie',
                    rating: 7.9,
                    actionButton: _PreviewHeart(
                      isFavorited: _fav2,
                      onTap: () => setState(() => _fav2 = !_fav2),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Stand-in for the real favorite button, so this file does not depend on
/// `features/`. Swap for the design-system `FavoriteButton` once it exists.
class _PreviewHeart extends StatelessWidget {
  const _PreviewHeart({required this.isFavorited, required this.onTap});

  final bool isFavorited;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Icon(
      isFavorited ? Icons.favorite : Icons.favorite_border,
      size: 20,
      color: Theme.of(context).colorScheme.onSurface,
    ),
  );
}
