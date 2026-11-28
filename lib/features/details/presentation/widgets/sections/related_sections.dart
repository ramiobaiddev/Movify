import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/features/details/presentation/feeds/related_fetchers.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/related/related_row.dart';

/// Recommended and Similar rows.
class RelatedSections extends StatelessWidget {
  const RelatedSections({super.key, required this.content});

  final DetailsContent content;

  @override
  Widget build(BuildContext context) {
    final fetchers = getIt<RelatedFetchers>();
    final kind = content.kind;
    final id = content.id;

    return Column(
      children: [
        RelatedRow(
          title: 'Recommended',
          queryKey: 'recommended-$kind-$id',
          fetcher: fetchers.recommended(kind, id),
        ),
        const SizedBox(height: Space.x3xl),
        RelatedRow(
          title: 'Similar',
          queryKey: 'similar-$kind-$id',
          fetcher: fetchers.similar(kind, id),
        ),
      ],
    );
  }
}
