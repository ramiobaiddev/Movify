import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/cubit/row_kind_cubit.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_poster_row.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';
import 'package:movify/shared/presentation/widgets/media_kind_sheet.dart';

/// "For you" / "All-time favorites": a row whose Movies/Series choice is
/// remembered per [rowId] and changed from a bottom sheet.
class HomeChipRow extends StatelessWidget {
  const HomeChipRow({
    super.key,
    required this.rowId,
    required this.title,
    required this.fetchers,
    required this.filters,
    required this.onItemTap,
    required this.onSeeAll,
  });

  final String rowId;
  final String title;
  final FeedFetchers fetchers;

  /// Same filters for both kinds (popularity for "For you", rating for
  /// "All-time favorites").
  final DiscoverFilters filters;
  final ValueChanged<CardDisplayModel> onItemTap;

  /// Receives the kind currently shown, so See all opens on the same one.
  final ValueChanged<ContentType> onSeeAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => RowKindCubit(rowId: rowId),
      child: BlocBuilder<RowKindCubit, ContentType>(
        builder: (context, kind) => HomePosterRow(
          title: title,
          queryKey: kind,
          fetcher: fetchers.discover(kind, filters),
          kindLabel: kind == ContentType.movies ? l10n.movies : l10n.tvShows,
          onKindTap: () async {
            final cubit = context.read<RowKindCubit>();
            final picked = await showMediaKindSheet(context, selected: kind);
            if (picked != null) cubit.select(picked);
          },
          onSeeAll: () => onSeeAll(kind),
          onItemTap: onItemTap,
        ),
      ),
    );
  }
}
