import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_cubit.dart';

class DetailsWidgetError extends StatelessWidget {
  const DetailsWidgetError({
    super.key,
    required this.message,
    required this.data,
  });

  final String message;
  final DetailsNavigationData data;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: Space.x3xl),
    child: PagedErrorView(
      message: message,
      onRetry: () =>
          context.read<DetailsCubit>().load(data.contentType, data.tmdbId),
    ),
  );
}
