enum TmdbImageSize {
  w92,
  w154,
  w185,
  w300,
  w500,
  w780,

  /// Profile photos only (people); 632 px tall, the largest non-original size.
  h632,
  original;

  String get path => 'https://image.tmdb.org/t/p/$name';
}

String tmdbImageSize(TmdbImageSize size, String path) => '${size.path}$path';
