import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movify/features/search/presentation/views/search_view.dart';

/// Injects SearchCubit into the SearchView subtree.
class SearchMultiProviders extends StatelessWidget {
  const SearchMultiProviders({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<SearchCubit>(),
    child: const SearchView(),
  );
}
