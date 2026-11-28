import 'package:movify/features/details/presentation/models/season_content.dart';

/// Where [number] sits in a season: the episode itself and its neighbours.
/// [current] is null while the season is loading or the number is unknown.
class EpisodePosition {
  EpisodePosition._(this.current, this.previous, this.next);

  factory EpisodePosition(List<EpisodeItem> episodes, int number) {
    final index = episodes.indexWhere((e) => e.number == number);
    if (index < 0) {
      return EpisodePosition._(null, null, null);
    }
    return EpisodePosition._(
      episodes[index],
      index > 0 ? episodes[index - 1] : null,
      index < episodes.length - 1 ? episodes[index + 1] : null,
    );
  }

  final EpisodeItem? current;
  final EpisodeItem? previous;
  final EpisodeItem? next;
}
