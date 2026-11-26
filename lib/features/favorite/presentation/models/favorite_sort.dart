import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';

enum FavoriteSort {
  recentlyAdded('Recently added'),
  title('Title A to Z'),
  rating('Highest rated'),
  releaseDate('Newest release');

  const FavoriteSort(this.label);

  final String label;

  /// A sorted copy. Items without the sorted value go last, and ties fall back
  /// to the title so the order never jumps between rebuilds.
  List<FavoriteEntity> apply(List<FavoriteEntity> items) {
    final sorted = [...items];
    sorted.sort((a, b) {
      final byKey = switch (this) {
        FavoriteSort.recentlyAdded => _newestFirst(a.addedAt, b.addedAt),
        FavoriteSort.title => _compareTitles(a, b),
        FavoriteSort.rating => b.rating.compareTo(a.rating),
        FavoriteSort.releaseDate => _newestFirst(
          DateTime.tryParse(a.date),
          DateTime.tryParse(b.date),
        ),
      };
      return byKey != 0 ? byKey : _compareTitles(a, b);
    });
    return sorted;
  }

  static int _newestFirst(DateTime? a, DateTime? b) {
    if (a == null && b == null) {
      return 0;
    }
    if (a == null) {
      return 1;
    }
    if (b == null) {
      return -1;
    }
    return b.compareTo(a);
  }

  static int _compareTitles(FavoriteEntity a, FavoriteEntity b) =>
      a.title.toLowerCase().compareTo(b.title.toLowerCase());
}
