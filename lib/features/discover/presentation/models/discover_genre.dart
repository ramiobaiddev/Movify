import 'package:movify/core/utils/enums/content_type.dart';

/// One of the genre chips on Discover. TMDB numbers movie and tv genres
/// differently, so each chip carries both ids.
class DiscoverGenre {
  const DiscoverGenre(this.name, this.movieId, this.tvId);

  final String name;
  final int movieId;
  final int tvId;

  int idFor(ContentType kind) => kind == ContentType.movies ? movieId : tvId;

  static const all = <DiscoverGenre>[
    DiscoverGenre('Action', 28, 10759),
    DiscoverGenre('Comedy', 35, 35),
    DiscoverGenre('Drama', 18, 18),
    DiscoverGenre('Crime', 80, 80),
    DiscoverGenre('Animation', 16, 16),
  ];
}
