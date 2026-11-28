import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/cast_row.dart';
import 'package:movify/features/details/presentation/widgets/sections/collection_row.dart';
import 'package:movify/features/details/presentation/widgets/sections/details_intro.dart';
import 'package:movify/features/details/presentation/widgets/sections/information_section.dart';
import 'package:movify/features/details/presentation/widgets/sections/related_sections.dart';
import 'package:movify/features/details/presentation/widgets/sections/reviews_section.dart';
import 'package:movify/features/details/presentation/widgets/sections/series_episode_sections.dart';
import 'package:movify/features/details/presentation/widgets/sections/videos_section.dart';
import 'package:movify/features/details/presentation/widgets/trailer_player.dart';

/// Everything under the header once the details have loaded, in order.
class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key, required this.content});

  final DetailsContent content;

  @override
  Widget build(BuildContext context) {
    final collectionId = content.collectionId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsIntro(content: content),
        const SizedBox(height: Space.x2xl),
        CastRow(cast: content.cast, onTap: (person) => context.openPerson(person.id)),
        SeriesEpisodeSections(content: content),
        const SizedBox(height: Space.x3xl),
        ReviewsSection(
          reviews: content.reviews,
          onSeeMore: () => context.openReviews(content.reviews),
        ),
        const SizedBox(height: Space.x3xl),
        if (collectionId != null) ...[
          CollectionRow(collectionId: collectionId, movieId: content.id),
          const SizedBox(height: Space.x3xl),
        ],
        InformationSection(rows: content.info),
        const SizedBox(height: Space.x3xl),
        if (content.videos.isNotEmpty) ...[
          VideosSection(
            videos: content.videos,
            onPlay: (video) => showTrailerPlayer(context, video),
          ),
          const SizedBox(height: Space.x3xl),
        ],
        RelatedSections(content: content),
        SizedBox(height: MediaQuery.paddingOf(context).bottom + Space.x3xl),
      ],
    );
  }
}
