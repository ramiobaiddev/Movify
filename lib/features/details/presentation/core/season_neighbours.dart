import 'package:movify/features/details/presentation/models/details_content.dart';

/// A series' seasons in order, and the ones either side of [currentNumber].
class SeasonNeighbours {
  SeasonNeighbours._(this.sorted, this.previous, this.next);

  factory SeasonNeighbours(List<SeasonItem> seasons, int currentNumber) {
    final sorted = [...seasons]..sort((a, b) => a.number.compareTo(b.number));
    final index = sorted.indexWhere((s) => s.number == currentNumber);
    if (index < 0) {
      return SeasonNeighbours._(sorted, null, null);
    }
    return SeasonNeighbours._(
      sorted,
      index > 0 ? sorted[index - 1] : null,
      index < sorted.length - 1 ? sorted[index + 1] : null,
    );
  }

  final List<SeasonItem> sorted;
  final SeasonItem? previous;
  final SeasonItem? next;

  bool get hasSeveral => sorted.length > 1;
}
