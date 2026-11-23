/// TMDB `trending/{media}/{window}`.
enum TrendingWindow {
  day('day'),
  week('week');

  const TrendingWindow(this.apiValue);
  final String apiValue;
}
