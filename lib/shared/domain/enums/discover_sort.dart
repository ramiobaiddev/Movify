/// Sort options shared by every See all screen. Mapped to each TMDB
/// endpoint's own field names in the data layer.
enum DiscoverSort {
  popularityDesc,
  popularityAsc,
  ratingDesc,
  ratingAsc,
  releaseDateDesc,
  releaseDateAsc,
  revenueDesc,
  revenueAsc;

  static const popularity = popularityDesc;
  static const rating = ratingDesc;
  static const newest = releaseDateDesc;
  static const oldest = releaseDateAsc;
  static const revenue = revenueDesc;

  bool get isAscending =>
      this == popularityAsc ||
      this == ratingAsc ||
      this == releaseDateAsc ||
      this == revenueAsc;

  DiscoverSort toggleDirection() => switch (this) {
    popularityDesc => popularityAsc,
    popularityAsc => popularityDesc,
    ratingDesc => ratingAsc,
    ratingAsc => ratingDesc,
    releaseDateDesc => releaseDateAsc,
    releaseDateAsc => releaseDateDesc,
    revenueDesc => revenueAsc,
    revenueAsc => revenueDesc,
  };
}
