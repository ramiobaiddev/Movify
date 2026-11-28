import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/fetch_series_season_details_cubit/fetch_series_season_details_cubit.dart';
import 'package:movify/features/details/presentation/views/old/season_view_body_old.dart';
import 'package:provider/provider.dart';

class SeasonViewOld extends StatefulWidget {
  const SeasonViewOld({super.key, required this.seasonDataNav});
  final SeasonNavData seasonDataNav;
  @override
  State<SeasonViewOld> createState() => _SeasonViewOldState();
}

class _SeasonViewOldState extends State<SeasonViewOld> {
  @override
  void initState() {
    final int tvid = widget.seasonDataNav.tmdbId;
    final int season = widget.seasonDataNav.seasonNumber;
    BlocProvider.of<FetchSeriesSeasonDetailsCubit>(
      context,
    ).fetchSeriesSeasonDetail(tvid: tvid, season: season);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Provider.value(
      value: widget.seasonDataNav,
      child: const SeasonViewBody(),
    ),
  );
}
