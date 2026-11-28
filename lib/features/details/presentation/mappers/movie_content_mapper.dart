import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/entites/movie_details_entity.dart';
import 'package:movify/features/details/presentation/mappers/content_parts.dart';
import 'package:movify/features/details/presentation/mappers/formatters.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

extension MovieDetailsContent on MovieDetailsEntity {
  DetailsContent toContent() {
    final release = parseDate(date);
    final budget = kBudget ?? 0;
    final revenue = kRevenue ?? 0;

    return DetailsContent(
      id: movieId,
      kind: ContentType.movies,
      title: movieTitle,
      posterPath: nonEmpty(posterImage),
      backdropPath: nonEmpty(backgroundImage),
      rating: ratingOrNull(rating),
      releaseDate: release,
      meta: [
        if (release != null) '${release.year}',
        if (formatRuntime(duration) case final runtime?) runtime,
      ],
      overview: overView,
      genres: genresOf(kGeners),
      cast: castOf(actorName),
      reviews: reviewsOf(kReviews?.results),
      videos: videosOf(kVideos?.results),
      collectionId: kBelongsToCollection?.id,
      info: [
        if (nonEmpty(movieStatus) case final status?)
          InfoRow(label: 'Status', value: status),
        ...originInfoRows(countries, companies, kLanguages),
        if (budget > 0) InfoRow(label: 'Budget', value: formatNumber(budget)),
        if (revenue > 0)
          InfoRow(label: 'Revenue', value: formatNumber(revenue)),
        if (formatRuntime(duration) case final runtime?)
          InfoRow(label: 'Runtime', value: runtime),
        if (release != null)
          InfoRow(label: 'Release date', value: formatDate(release)),
      ],
    );
  }
}
