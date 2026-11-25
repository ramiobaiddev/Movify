import 'package:movify/core/utils/enums/content_type.dart';

/// Result of moving a genre selection from one kind to the other.
class GenreMapResult {
  const GenreMapResult({required this.mapped, required this.dropped});

  /// Ids valid for the target kind.
  final Set<int> mapped;

  /// Source ids that have no equivalent (shown to the user as a message).
  final Set<int> dropped;
}

/// TMDB movie and tv genre ids differ. Matching is by name:
///  - identical names keep their id (Animation, Comedy, Crime, ...)
///  - tv "Action & Adventure" <-> movie Action (Adventure folds into it)
///  - tv "Sci-Fi & Fantasy" <-> movie Science Fiction (Fantasy folds into it)
///  - tv "War & Politics" <-> movie War
/// Anything else (Horror, Romance, Kids, Reality, ...) is dropped.
abstract final class GenreMapping {
  static const _movieToTv = <int, int>{
    28: 10759, // Action
    12: 10759, // Adventure
    878: 10765, // Science Fiction
    14: 10765, // Fantasy
    10752: 10768, // War
    16: 16, // Animation
    35: 35, // Comedy
    80: 80, // Crime
    99: 99, // Documentary
    18: 18, // Drama
    10751: 10751, // Family
    9648: 9648, // Mystery
    37: 37, // Western
  };

  static const _tvToMovie = <int, int>{
    10759: 28,
    10765: 878,
    10768: 10752,
    16: 16,
    35: 35,
    80: 80,
    99: 99,
    18: 18,
    10751: 10751,
    9648: 9648,
    37: 37,
  };

  static GenreMapResult convert(
    Set<int> ids, {
    required ContentType from,
    required ContentType to,
  }) {
    if (from == to) {
      return GenreMapResult(mapped: ids, dropped: const {});
    }
    final table = from == ContentType.movies ? _movieToTv : _tvToMovie;
    final mapped = <int>{};
    final dropped = <int>{};
    for (final id in ids) {
      final target = table[id];
      target == null ? dropped.add(id) : mapped.add(target);
    }
    return GenreMapResult(mapped: mapped, dropped: dropped);
  }
}
