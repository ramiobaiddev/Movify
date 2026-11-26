enum SearchTab {
  moviesAndSeries,
  movies,
  series,
  people,
  keywords;

  String get label => switch (this) {
    SearchTab.moviesAndSeries => 'Movies & series',
    SearchTab.movies => 'Movies',
    SearchTab.series => 'Series',
    SearchTab.people => 'People',
    SearchTab.keywords => 'Keywords',
  };
}
