import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/keyword.dart';

/// A hand-picked list, backed by a TMDB keyword.
class DiscoverCollection {
  const DiscoverCollection({
    required this.keyword,
    required this.description,
    required this.moviePicture,
    required this.tvPicture,
  });

  final Keyword keyword;
  final String description;

  /// TMDB image paths, one per kind so the picture matches the list.
  final String moviePicture;
  final String tvPicture;

  String get name => keyword.name;

  String pictureFor(ContentType kind) =>
      kind == ContentType.movies ? moviePicture : tvPicture;

  static const all = <DiscoverCollection>[
    DiscoverCollection(
      keyword: Keyword(id: 6513, name: 'Cartoons'),
      description: 'Colorful fun, cozy laughs, and pure good vibes',
      moviePicture: '/w9kR8qbmQ01HwnvK4alvnQ2ca0L.jpg',
      tvPicture: '/qk3eQ8jW4opJ48gFWYUXWaMT4l.jpg',
    ),
    DiscoverCollection(
      keyword: Keyword(id: 10391, name: 'Mafia'),
      description: 'Power, loyalty, betrayal: the underworld stories.',
      moviePicture: '/loSpBeirRfTPJ3cMIqpQArstGhh.jpg',
      tvPicture: '/rTc7ZXdroqjkKivFPvCPX0Ru7uw.jpg',
    ),
    DiscoverCollection(
      keyword: Keyword(id: 210024, name: 'Anime'),
      description: 'Epic worlds, deep emotions, unforgettable battles.',
      moviePicture: '/fWVSwgjpT2D78VUh6X8UBd2rorW.jpg',
      tvPicture: '/fHpKWq9ayzSk8nSwqRuaAUemRKh.jpg',
    ),
    DiscoverCollection(
      keyword: Keyword(id: 180547, name: 'Marvel'),
      description: 'Heroes, villains, and multiverse madness, all in one place.',
      moviePicture: '/9BBTo63ANSmhC4e6r62OJFuK2GL.jpg',
      tvPicture: '/gHUCCMy1vvj58tzE3dZqeC9SXus.jpg',
    ),
  ];
}
