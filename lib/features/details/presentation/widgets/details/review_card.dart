import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/shared/presentation/widgets/common/expandable_text.dart';
import 'package:movify/shared/presentation/widgets/cards/person_avatar.dart';

/// One user review: avatar, name, date, rating and the text (4 lines, then
/// Read more).
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewItem review;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final small = textTheme.bodySmall?.copyWith(color: colors.textPrimary);
    final date = review.createdAt;
    final rating = review.rating;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceCommentCard,
        borderRadius: BorderRadius.circular(Radii.md),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.lg,
          vertical: Space.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Avatar(path: review.avatarPath),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.author,
                        style: small,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (date != null) ...[
                        const SizedBox(height: Space.xsm),
                        Text(DateFormat.yMMMd().format(date), style: small),
                      ],
                    ],
                  ),
                ),
                if (rating != null) ...[
                  Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: colors.statusWarning,
                  ),
                  const SizedBox(width: Space.xsm),
                  Text(rating.toStringAsFixed(1), style: small),
                ],
              ],
            ),
            const SizedBox(height: Space.lg),
            ExpandableText(text: review.content, maxLines: 4),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.path});

  final String? path;

  static const double _size = 63;

  @override
  Widget build(BuildContext context) {
    final value = path;
    if (value != null && value.startsWith('http')) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: value,
          width: _size,
          height: _size,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) =>
              const PersonAvatar(profilePath: null, size: _size),
        ),
      );
    }
    return PersonAvatar(profilePath: value, size: _size);
  }
}
