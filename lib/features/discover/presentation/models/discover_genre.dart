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

/// A genre in the full directory.
class GenreOption {
  const GenreOption(this.name, this.id);

  final String name;
  final int id;

  /// Every genre worth browsing, per kind (ids differ between movie and tv).
  static List<GenreOption> forKind(ContentType kind) =>
      kind == ContentType.movies ? _movies : _tv;

  static const _movies = <GenreOption>[
    GenreOption('Action', 28),
    GenreOption('Adventure', 12),
    GenreOption('Animation', 16),
    GenreOption('Comedy', 35),
    GenreOption('Crime', 80),
    GenreOption('Documentary', 99),
    GenreOption('Drama', 18),
    GenreOption('Family', 10751),
    GenreOption('Fantasy', 14),
    GenreOption('History', 36),
    GenreOption('Horror', 27),
    GenreOption('Music', 10402),
    GenreOption('Mystery', 9648),
    GenreOption('Romance', 10749),
    GenreOption('Science Fiction', 878),
    GenreOption('Thriller', 53),
    GenreOption('War', 10752),
    GenreOption('Western', 37),
  ];

  static const _tv = <GenreOption>[
    GenreOption('Action & Adventure', 10759),
    GenreOption('Animation', 16),
    GenreOption('Comedy', 35),
    GenreOption('Crime', 80),
    GenreOption('Documentary', 99),
    GenreOption('Drama', 18),
    GenreOption('Family', 10751),
    GenreOption('Kids', 10762),
    GenreOption('Mystery', 9648),
    GenreOption('Sci-Fi & Fantasy', 10765),
    GenreOption('War & Politics', 10768),
    GenreOption('Western', 37),
  ];
}
